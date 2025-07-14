#!/bin/bash

# Initial attempt to start the blueman-applet
blueman-applet &
# Sleep for 5 seconds to make sure attempt executed
sleep 5
# Do the first check and kill the first instance that fails to draw icon
if pgrep -x "blueman-applet" >/dev/null; then
	pkill -x "blueman-applet"
	sleep 2
fi
# tragain
blueman-applet &
# Check if ok and if ok exit before the loop
if pgrep -x "blueman-applet" >/dev/null; then
	exit 0
fi
