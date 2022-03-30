#!/bin/sh

LOG="$HOME/.polybar.log"

# Terminate already running bar instances
polybar-msg cmd quit
test -e $LOG && rm -f $LOG

# Launch bars
MONITOR=DP-2 polybar main >> $LOG 2>&1 & disown
MONITOR=DP-4 polybar secondary >> $LOG 2>&1 & disown
