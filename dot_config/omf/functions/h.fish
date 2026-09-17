function h -d "Start or attach to herdr session"
  zoxide-seed-devel

  # Allow SSH agent forwarding to follow last inbound connection.
  set inbound_auth_sock ~/.ssh/ssh_auth_sock
  if test -S $inbound_auth_sock
    set -x SSH_AUTH_SOCK $inbound_auth_sock
  end

  herdr
end
