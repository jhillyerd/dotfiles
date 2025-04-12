#!/bin/sh

killall yambar
yambar >"$HOME/.yambar.log" 2>&1 & disown

lock="$HOME/.scripts/lock-screen-sway.sh"
killall swayidle
swayidle -w \
  lock $lock \
  timeout 300 $lock \
  timeout 600 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' \
  before-sleep $lock & disown

killall wl-paste
wl-paste -t text --watch clipman store --no-persist & disown
