#!/bin/bash
killall clipit pamac-tray blueman-applet nm-applet pa-applet xfce4-power-manager flameshot

clipit &
sleep 2

pamac-tray &
sleep 2

blueman-applet &
sleep 2

nm-applet &
sleep 2

pa-applet &
sleep 2

flameshot &
sleep 2
