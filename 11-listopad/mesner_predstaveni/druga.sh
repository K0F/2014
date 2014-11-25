#!/bin/bash
sudo ls
hdmi 1280x800
rmdir /tmp/mplayercontrol
mkfifo /tmp/mplayercontrol
export DISPLAY=:1
xset -dpms
xset s off
cd /sketchBook/2014/11-listopad/mesner_predstaveni/mplayerControl
ppop
mplayer -capture -loop 0 -osdlevel 0 none -slave -input file=/tmp/mplayercontrol ~/render/mesner_predstaveni/VTS_03_2.VOB
