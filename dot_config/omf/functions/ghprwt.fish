function ghprwt -a pr -d "Check out a GitHub PR into a herdr worktree (like gh pr checkout)"
  if test -z "$pr"
    echo "Usage: ghprwt <number|url|branch>"
    echo "  Opens the PR's branch in a herdr worktree workspace, re-using an"
    echo "  existing worktree or local branch when present."
    return 1
  end
  if test -z "$HERDR_PANE_ID"
    echo "ghprwt: not running inside herdr" >&2
    return 1
  end

  set -l toplevel (git rev-parse --show-toplevel 2>/dev/null)
  or begin
    echo "ghprwt: not in a git repository" >&2
    return 1
  end

  # Resolve PR metadata.
  set -l info (gh pr view $pr --json number,headRefName,isCrossRepository,headRepositoryOwner,url \
    --jq '[.number, .headRefName, .isCrossRepository, .headRepositoryOwner.login, .url] | @tsv')
  or return 1
  set -l fields (string split \t -- $info)
  set -l num $fields[1]
  set -l branch $fields[2]
  set -l cross $fields[3]
  set -l owner $fields[4]
  set -l url $fields[5]

  # Mirror gh's naming: a fork PR from its default branch gets "<owner>/<branch>".
  if test "$cross" = true
    set -l default_branch (gh repo view --json defaultBranchRef --jq .defaultBranchRef.name 2>/dev/null)
    if test "$branch" = "$default_branch"
      set branch "$owner/$branch"
    end
  end

  # 1. Existing worktree for this branch: just open/focus it.
  set -l wt_path (herdr worktree list --cwd $toplevel \
    | jq -r --arg b $branch '.result.worktrees[] | select(.branch == $b) | .path' | head -n1)
  if test -n "$wt_path"
    echo "ghprwt: opening existing worktree $wt_path ($branch)"
    herdr worktree open --cwd $toplevel --path $wt_path --focus >/dev/null
    return $status
  end

  # 2. No local branch yet: fetch the PR head so herdr checks out the PR rather
  #    than branching from HEAD.
  if not git -C $toplevel show-ref --verify --quiet refs/heads/$branch
    # Find the remote pointing at the PR's base repo; fall back to origin.
    set -l repo (string replace -r '^https://github\.com/([^/]+/[^/]+)/pull/.*$' '$1' -- $url)
    set -l remote origin
    for r in (git -C $toplevel remote)
      if string match -qr "github\.com[:/]$repo(\.git)?/?\$" -- (git -C $toplevel remote get-url $r)
        set remote $r
        break
      end
    end
    echo "ghprwt: fetching PR #$num from $remote into $branch"
    git -C $toplevel fetch $remote "pull/$num/head:refs/heads/$branch"
    or return 1
  end

  # 3. Create the worktree on the (now existing) local branch.
  set -l result (herdr worktree create --cwd $toplevel --branch $branch --focus)
  or return 1
  set -l new_path (printf '%s' $result | jq -r '.result.worktree.path // empty')
  if test -z "$new_path"
    set new_path (herdr worktree list --cwd $toplevel \
      | jq -r --arg b $branch '.result.worktrees[] | select(.branch == $b) | .path' | head -n1)
  end
  if test -z "$new_path"
    echo "ghprwt: could not determine worktree path from herdr response:" >&2
    printf '%s\n' $result >&2
    return 1
  end

  # Let gh configure tracking/push remotes and fast-forward to the PR head.
  echo "ghprwt: created worktree $new_path ($branch)"
  env -C $new_path gh pr checkout $num --branch $branch
  or echo "ghprwt: warning: 'gh pr checkout' failed in $new_path; branch tracking may be unset" >&2
end
