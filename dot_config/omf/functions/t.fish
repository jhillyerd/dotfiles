function t -a session -d "Start or attach to tmux session"
  if test "$session" = ""
    if test (pwd) = $HOME
      set session (hostname)
    else
      set session (basename (pwd) | sed 's/[^a-zA-Z0-9]/-/g')
    end
  end

  # Allow SSH agent forwarding to follow last inbound connection.
  set inbound_auth_sock ~/.ssh/ssh_auth_sock
  if test -S $inbound_auth_sock
    set -x SSH_AUTH_SOCK $inbound_auth_sock
  end

  # Creates a new session, but connects to same window group
  tmux new-session -t $session
end
