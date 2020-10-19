#!/bin/bash

choices="Logout\nPoweroff\nReboot"
fg=$(xrdb -query | grep foreground | cut -d':' -f2 | sed 's/	//g')
bg=$(xrdb -query | grep background | cut -d':' -f2 | sed 's/	//g')
chosen=$(echo -e $choices | prompt "Powermenu")
echo "$chosen"

case "$chosen" in
	Logout) bspc quit ;;
	Poweroff) poweroff ;;
	Reboot) reboot ;; 
esac