#!/bin/sh

maim --select | tee ~/Pictures/$(date +%s).png | xclip -selection clipboard -t image/png
