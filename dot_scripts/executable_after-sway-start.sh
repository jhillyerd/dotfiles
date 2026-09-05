#!/bin/sh

killall noctalia
noctalia >"$HOME/.noctalia.log" 2>&1 & disown

# Idle behavior (screen lock/off) and the clipboard manager are provided
# by Noctalia. Previously swayidle and clipman were started here.

if command -v 1password > /dev/null 2>&1; then
    if ! pgrep -x 1password > /dev/null; then
        1password --silent > /dev/null 2>&1 & disown
    fi
fi
