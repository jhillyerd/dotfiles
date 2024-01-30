function ssh -w ssh
  if status --is-interactive; and set -q TMUX
    # Tell ssh_config LocalCommand script to set title.
    set -x _ssh_tmux_title 1
  end

  command ssh $argv

  if set -q _ssh_tmux_title
    tmux set -w automatic-rename on
  end
end
