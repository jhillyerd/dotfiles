function t -a session -d "Start or attach to tmux session"
  if test "$session" = ""
    if test (pwd) = $HOME
      set session (hostname)
    else
      set session (basename (pwd) | sed 's/[^a-zA-Z0-9]/-/g')
    end
  end

  # Prompt for ssh-key if needed
  if command -q -s ssh-add; and not ssh-add -l >/dev/null
    ssh-add
  end

  # Creates a new session, but connects to same window group
  tmux new-session -t $session
end
