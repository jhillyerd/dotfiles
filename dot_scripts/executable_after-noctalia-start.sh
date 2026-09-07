#!/bin/sh

# Runs from Noctalia's [hooks] started hook (~/.config/noctalia/config.toml),
# backgrounded there so Noctalia startup is never blocked by the wait below.

# Launch 1Password only after Noctalia's tray host (StatusNotifierWatcher)
# is actually on the session bus. The `started` hook fires at "IPC ready",
# which can precede tray-host registration; if 1Password creates its tray
# before the watcher exists it falls back to legacy XEmbed (invisible on
# sway) and never retries. Previously started by after-sway-start.sh.

command -v 1password >/dev/null 2>&1 || exit 0

# Wait up to 30s for the tray host to register on the session bus.
for i in $(seq 1 60); do
    busctl --user status org.kde.StatusNotifierWatcher >/dev/null 2>&1 && break
    sleep 0.5
done

pgrep -x 1password >/dev/null && exit 0

exec 1password --silent >/dev/null 2>&1
