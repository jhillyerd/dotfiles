function np -a project -d "nix-project: cd <project> + nix-shell + tmux"
  # Prompt for ssh-key if needed
  if command -q -s ssh-add; and not ssh-add -l >/dev/null
    ssh-add
  end

  cd $HOME/devel/$project
  nix-shell --command "SHELL=fish; exec tmux new-session -t $project"
end
