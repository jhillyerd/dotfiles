#!/bin/sh

LOG="$HOME/.yambar.log"
killall yambar
yambar >$LOG 2>&1 & disown
