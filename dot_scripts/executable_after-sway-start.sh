#!/bin/sh

killall noctalia
noctalia >"$HOME/.noctalia.log" 2>&1 & disown

# Idle behavior (screen lock/off) and the clipboard manager are provided
# by Noctalia. Previously swayidle and clipman were started here.

# 1Password is started by after-noctalia-start.sh, called from Noctalia's
# [hooks] started hook, so it launches only once the tray host is ready
# (see ~/.config/noctalia/config.toml).
