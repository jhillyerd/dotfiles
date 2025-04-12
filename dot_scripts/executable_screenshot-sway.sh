#!/bin/sh

slurp | grim -g - - | tee ~/Pictures/$(date +%s).png | wl-copy
