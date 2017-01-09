#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
MONITOR=DP-1 polybar top &
MONITOR=DP-1 polybar bottom &
MONITOR=VGA-1 polybar bottom &
