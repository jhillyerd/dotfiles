function __rmwt_complete_branches
  set -l root (git rev-parse --show-toplevel 2>/dev/null)
  or return 1
  herdr worktree list --cwd $root 2>/dev/null \
    | jq -r '.result.worktrees[] | select(.is_linked_worktree == true) | .branch' 2>/dev/null
end

complete -c rmwt -f -a '(__rmwt_complete_branches)'
complete -c rmwt -s f -l force -d 'Discard uncommitted work and unmerged commits'
