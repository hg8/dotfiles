#!/bin/bash
if [ $(xrandr -d :0 -q | grep ' connected' | wc -l) -ge 2 ]
then
    xrandr --output HDMI1 --off --output DP1 --primary --mode 3840x2160 --pos 3200x0 --rotate normal --output eDP1 --mode 3200x1800 --pos 0x0 --rotate normal --output VIRTUAL1 --off
fi
