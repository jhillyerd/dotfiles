function rmwt -d "Remove a herdr worktree workspace and its branch"
  argparse h/help f/force -- $argv
  or return 1

  if set -q _flag_help
    echo "Usage: rmwt [-f|--force] [<branch>]"
    echo
    echo "  Removes the herdr worktree for <branch> (exact or unique substring"
    echo "  match), or the worktree containing the current directory when no"
    echo "  branch is given, and deletes its branch."
    echo
    echo "  Safety checks, bypass with -f:"
    echo "    - worktree must be clean (no modified or untracked files)"
    echo "    - branch must be merged into its upstream or the default branch,"
    echo "      or have a merged GitHub PR with the same head (squash/rebase)"
    return 0
  end

  if test (count $argv) -gt 1
    echo "rmwt: expected at most one branch argument" >&2
    return 1
  end
  set -l target $argv[1]

  set -l root (git rev-parse --show-toplevel 2>/dev/null)
  or begin
    echo "rmwt: not in a git repository" >&2
    return 1
  end
  set -l real_root (realpath $root)

  # branch<TAB>workspace<TAB>detached<TAB>linked<TAB>path
  set -l rows (herdr worktree list --cwd $root 2>/dev/null \
    | jq -r '.result.worktrees[] | [.branch, .open_workspace_id, .is_detached, .is_linked_worktree, .path] | @tsv' 2>/dev/null)
  if test (count $rows) -eq 0
    echo "rmwt: herdr returned no worktrees for $root" >&2
    return 1
  end

  set -l sel_row ""
  if test -n "$target"
    for row in $rows
      set -l f (string split \t -- $row)
      if test "$f[4]" = true; and test "$f[1]" = "$target"
        set sel_row $row
        break
      end
    end
    if test -z "$sel_row"
      set -l matches
      for row in $rows
        set -l f (string split \t -- $row)
        if test "$f[4]" = true; and string match -qi -- "*$target*" $f[1]
          set -a matches $row
        end
      end
      if test (count $matches) -eq 1
        set sel_row $matches[1]
      else
        if test (count $matches) -gt 1
          echo "rmwt: '$target' matches multiple worktrees:" >&2
          for row in $matches
            set -l f (string split \t -- $row)
            echo "  "$f[1]"  ("$f[5]")" >&2
          end
        else
          set -l avail
          for row in $rows
            set -l f (string split \t -- $row)
            test "$f[4]" = true; and set -a avail $f[1]
          end
          if test (count $avail) -gt 0
            echo "rmwt: no worktree branch matching '$target'; available:" >&2
            printf '  %s\n' $avail >&2
          else
            echo "rmwt: no worktree branch matching '$target', and no linked worktrees" >&2
          end
        end
        return 1
      end
    end
  else
    for row in $rows
      set -l f (string split \t -- $row)
      if test "$f[4]" = true; and test "$f[5]" = "$real_root"
        set sel_row $row
        break
      end
    end
    if test -z "$sel_row"
      echo "rmwt: not inside a linked worktree; specify a branch" >&2
      return 1
    end
  end

  set -l f (string split \t -- $sel_row)
  set -l branch $f[1]
  set -l ws $f[2]
  set -l detached $f[3]
  set -l path $f[5]
  set -l forced ""
  set -q _flag_force; and set forced true

  # Guard: uncommitted or untracked work.
  if test -z "$forced"
    if test (git -C $path status --porcelain 2>/dev/null | count) -gt 0
      echo "rmwt: $path has modified or untracked files:" >&2
      git -C $path status --short >&2
      echo "rmwt: use -f to discard them" >&2
      return 1
    end
  end

  # Guard: unmerged commits.
  set -l merged_into ""
  if test "$detached" != true; and test -n "$branch"; and test -z "$forced"
    set -l upstream (git -C $root rev-parse --abbrev-ref --symbolic-full-name "$branch@{upstream}" 2>/dev/null)
    set -l candidates (__rmwt_default_refs $root)
    test -n "$upstream"; and set -a candidates $upstream
    for ref in $candidates
      if git -C $root merge-base --is-ancestor $branch $ref 2>/dev/null
        set merged_into $ref
        break
      end
    end
    set -l prs
    if test -z "$merged_into"
      # Squash and rebase merges break ancestry: also accept a merged PR
      # (gh) whose head matches the local branch tip.
      set -l tip (git -C $root rev-parse $branch)
      set prs (__rmwt_merged_pr $root $branch)
      set -l merged_pr
      for pr in $prs
        set -l p (string split \t -- $pr)
        if test "$p[2]" = "$tip"
          set merged_pr $p[1]
          break
        end
      end
      if test -n "$merged_pr"
        set merged_into "PR #$merged_pr"
      end
    end
    if test -z "$merged_into"
      set -l any_pr
      for pr in $prs
        set -l p (string split \t -- $pr)
        contains -- "#$p[1]" $any_pr; or set -a any_pr "#$p[1]"
      end
      if test (count $any_pr) -gt 0
        echo "rmwt: PR "(string join ", " -- $any_pr)" merged, but branch '$branch' has commits after the merged head:" >&2
      else
        echo "rmwt: branch '$branch' has commits not merged into "(string join ", " -- $candidates)":" >&2
        set -l base $candidates[1]
        git -C $root log --oneline --no-decorate "$base..$branch" >&2
      end
      echo "rmwt: use -f to delete anyway (tip: "(git -C $root rev-parse --short $branch)")" >&2
      return 1
    end
  end

  if test "$real_root" = "$path"
    # This pane is inside the target worktree: removing the workspace kills
    # this shell, so detach and delete the branch first.
    if test "$detached" != true; and test -n "$branch"
      git -C $path checkout --detach -q
      or begin
        echo "rmwt: could not detach HEAD in $path" >&2
        return 1
      end
      __rmwt_delete_branch $root $branch $merged_into $forced
      or return 1
    end
    echo "rmwt: removing worktree $path (this pane will close)"
    __rmwt_remove $root $ws $path $forced
    return $status
  end

  __rmwt_remove $root $ws $path $forced
  or return 1
  if test "$detached" != true; and test -n "$branch"
    __rmwt_delete_branch $root $branch $merged_into $forced
    or return 1
  end
end

function __rmwt_merged_pr -a root branch
  # Merged PRs for a head branch, as "number<TAB>headRefOid" lines. Covers
  # squash/rebase merges where ancestry checks fail. Needs gh + a GitHub repo;
  # prints nothing when unavailable.
  command -sq gh; or return 0
  set -l heads $branch
  set -l parts (string split -m1 / -- $branch)
  if test (count $parts) -eq 2
    set -a heads "$parts[1]:$parts[2]" # fork PR branch "owner/branch" -> "owner:branch"
  end
  for h in $heads
    env -C $root gh pr list --state merged --head $h --limit 5 \
      --json number,headRefOid --jq '.[] | [.number, .headRefOid] | @tsv' 2>/dev/null
  end
end

function __rmwt_default_refs -a root -d "Default-branch refs for merge checks (remote and local)"
  set -l out
  set -l head (git -C $root symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null)
  if test -n "$head"
    set -a out $head (string replace -r '^origin/' '' -- $head)
  end
  for c in origin/main origin/master main master
    contains -- $c $out; or set -a out $c
  end
  for ref in $out
    git -C $root rev-parse --verify --quiet $ref >/dev/null 2>&1; and echo $ref
  end
end

function __rmwt_remove -a root ws path
  set -l extra $argv[5..-1]
  test "$argv[4]" = true; and set extra --force
  if test -n "$ws"
    herdr worktree remove --workspace $ws $extra >/dev/null 2>&1
    and begin
      echo "rmwt: removed herdr worktree $path (workspace $ws)"
      return 0
    end
    echo "rmwt: herdr worktree remove failed:" >&2
    herdr worktree remove --workspace $ws $extra 2>&1 | head -n 3 >&2
    echo "rmwt: falling back to git worktree remove" >&2
  end
  git -C $root worktree remove $extra $path >/dev/null 2>&1
  and begin
    echo "rmwt: removed worktree $path"
    return 0
  end
  echo "rmwt: git worktree remove failed:" >&2
  git -C $root worktree remove $extra $path 2>&1 | head -n 3 >&2
  return 1
end

function __rmwt_delete_branch -a root branch merged_into forced
  set -l flag -d
  # -D when forced, or when safety came from the PR check: squash/rebase
  # merges also fail git branch -d's own ancestry check.
  if test "$forced" = true; or string match -q 'PR #*' -- $merged_into
    set flag -D
  end
  if git -C $root branch $flag $branch >/dev/null 2>&1
    if test -n "$merged_into"
      echo "rmwt: deleted branch $branch (merged into $merged_into)"
    else
      echo "rmwt: deleted branch $branch"
    end
    return 0
  end
  echo "rmwt: failed to delete branch $branch:" >&2
  git -C $root branch $flag $branch 2>&1 | head -n 3 >&2
  echo "rmwt: run 'git -C $root branch $flag $branch' manually when ready" >&2
  return 1
end
