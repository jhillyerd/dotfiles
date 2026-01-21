#!/bin/sh

killall yambar
yambar >"$HOME/.yambar.log" 2>&1 & disown

lock="$HOME/.scripts/lock-screen-sway.sh"
killall swayidle
swayidle -w \
  lock $lock \
  timeout 600 $lock \
  timeout 900 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' \
  before-sleep $lock & disown

killall wl-paste
wl-paste -t text --watch clipman store --no-persist & disown

if command -v 1password > /dev/null 2>&1; then
    if ! pgrep -x 1password > /dev/null; then
        1password --silent > /dev/null 2>&1 & disown
    fi
fi
