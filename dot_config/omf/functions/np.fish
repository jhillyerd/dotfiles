function np -a project -d "nix-project: cd <project> + nix-shell + tmux"
  set -l project_dir $HOME/devel

  # Prompt for ssh-key if needed
  if command -q -s ssh-add; and not ssh-add -l >/dev/null
    ssh-add
  end

  pushd "$project_dir/$project"
  nix-shell --command "SHELL=fish; exec tmux new-session -t $project"
  popd
end
