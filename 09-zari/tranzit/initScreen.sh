#!/bin/bash
xrandr -d :0 --output LVDS1 --mode 1600x900
xrandr -d :0 --output VGA1 --mode 800x600 --left-of LVDS1
hdmi 800x600
