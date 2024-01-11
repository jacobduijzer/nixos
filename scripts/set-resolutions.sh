#!/usr/bin/env bash

xrandr \
  --fbmm 5760x4440 \
  --output eDP-1 --pos 960x0 --mode 1920x1200 --dpi 96 --scale 1x1 --primary \
  --output HDMI-1 --pos 0x1200 --mode 3840x2160 --dpi 96 --scale 1.5x1.5

#xrandr \
#--output eDP-1 --mode 1920x1200 --pos 960x0 --rotate normal --dpi 196 --scale 1x1 \
#--output HDMI-1 --mode 3840x2160 --pos 0x1200 --rotate normal --dpi 96 --scale 1.5x1.5
#xrandr \
#--output eDP-1 --mode 1920x1200 --pos 960x0 --rotate normal --dpi 170 --scale 1x1 \
#--output HDMI-1 --mode 3840x2160 --pos 0x1200 --rotate normal --dpi 331 --scale 1.5x1.5
