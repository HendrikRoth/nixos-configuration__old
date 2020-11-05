#!/bin/bash

prompt="-p Action:"
choices="Poweroff\nHibernate\nReboot"
chosen="$(echo -e $choices | dmenu $prompt)"

case "$chosen" in
	Poweroff) systemctl poweroff ;;
    Hibernate) systemctl hibernate ;;
	Reboot) systemctl reboot ;; 
esac
