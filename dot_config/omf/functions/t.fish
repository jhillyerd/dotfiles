function t -d "Start or attach to tmux session"
  # Prompt for ssh-key if needed
  if command -q -s ssh-add; and not ssh-add -l >/dev/null
    ssh-add
  end

  # Creates a new session, but connects to same window group main
  set -l args new-session -t main
  if test -x /usr/bin/tmx2
    tmx2 $args
  else
    tmux $args
  end
end
