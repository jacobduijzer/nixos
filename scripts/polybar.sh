#!/usr/bin/env bash

SOURCE=${BASH_SOURCE[0]}
DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )

CONFIG_FILE="$HOME/.config/polybar/config.ini"

# Add this script to your wm startup file.

# Terminate already running bar instances
kill $(ps ax | grep polybar | grep reload | awk '{print $1}')

loglevel=info

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

number_of_connected_screens=$(xrandr --query | grep " connected" | wc -l)
xrandr --query | grep " connected" > /tmp/xrandrtest.log
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    echo $m
    MONITOR=$m polybar --reload $m -c "$CONFIG_FILE" -l $loglevel &

    if [ $number_of_connected_screens -eq 2 ] && [ $m == "eDP1" ]; then
      MONITOR=$m polybar --reload status -c "$CONFIG_FILE" -l $loglevel &
    fi
  done
fi


# Launch the bar
#polybar -q main -c "$DIR"/config.ini &
