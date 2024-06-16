#!/bin/sh

xrandr --dpi 96
xrandr --output DP-1 --mode 3440x1440 --pos 0x0 --rotate normal --primary
xrandr --output DP-2 --mode 3840x2160 --right-of DP-1 --rotate normal --scale 0.5

$HOME/.scripts/polybar-start.sh
