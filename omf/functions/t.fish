function t -d "Start or attach to tmux session"
  # Creates a new session, but connects to same window group main
  set -l args new-session -t main
  if test -x /usr/bin/tmx
    tmx $args
  else
    tmux $args
  end
end
