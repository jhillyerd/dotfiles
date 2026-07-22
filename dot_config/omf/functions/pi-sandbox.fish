function pi-sandbox -d "Run Pi in nono with Git worktree support"
  set -l nono_args run --profile pi --allow-cwd

  # A linked worktree keeps its writable Git metadata in the main checkout's
  # .git directory, which is outside the worktree allowed by --allow-cwd.
  if set -l git_common_dir (command git rev-parse --path-format=absolute --git-common-dir 2>/dev/null)
    set -a nono_args --allow $git_common_dir
  end

  command nono $nono_args -- pi $argv
end
