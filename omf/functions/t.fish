function t -d "Start or attach to tmux session"
  if test -x /usr/bin/tmx
    tmx a; or tmx
  else
    tmux a; or tmux
  end
end
