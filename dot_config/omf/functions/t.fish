function t -a session -d "Start or attach to tmux session"
  # Allow SSH agent forwarding to follow last inbound connection.
  set inbound_auth_sock ~/.ssh/ssh_auth_sock
  if test -S $inbound_auth_sock
    set -x SSH_AUTH_SOCK $inbound_auth_sock
  end

  if test -n "$session"
    tmux new-session -t $session
    return
  end

  sesh connect (sesh list --icons \
    | fzf --height 40% --border --ansi --preview 'sesh preview {}')
end
