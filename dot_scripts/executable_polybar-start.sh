#!/bin/sh

LOG="$HOME/.polybar.log"

# Terminate already running bar instances
polybar-msg cmd quit
test -e $LOG && rm -f $LOG

monitors=( $(polybar --list-monitors | cut -d":" -f1) )
main="${monitors[0]}"

# Launch bars
MONITOR="$main" polybar main >> $LOG 2>&1 & disown

for secondary in "${array[@]:1}"; do
  MONITOR="$secondary" polybar secondary >> $LOG 2>&1 & disown
done
