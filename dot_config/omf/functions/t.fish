function t -a session -d "Start or attach to tmux session"
  if test "$session" = ""
    set session main
  end

  # Prompt for ssh-key if needed
  if command -q -s ssh-add; and not ssh-add -l >/dev/null
    ssh-add
  end

  # Creates a new session, but connects to same window group main
  set -l args new-session -t $session

  if test -x /usr/bin/tmx2
    tmx2 $args
  else
    tmux $args
  end
end
