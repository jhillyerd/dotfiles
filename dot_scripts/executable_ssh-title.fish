#!/usr/bin/env fish
if set -q _ssh_tmux_title
  tmux rename-window $argv
end
