#!/usr/bin/env bash

imageFolder=${$1:-$HOME/images/scrots}
cmdOptions="
Fullscreen
Section
Fullscreen saved
Section saved
Fullscreen uploaded
Section uploaded
"

cmd=$(dmenu -l 10 -p "Screenshot:" <<< "$cmdOptions")
filename='%Y-%m-%d-@%H-%M-%S-scrot.png'

case ${cmd%% *} in
    Fullscreen) scrot -d 1 $filename ;;
    Section) scrot -s $filename ;;
    Fullscreen saved) scrot -d 1 $filename ;;
    Section saved) scrot -s $filename ;;
    Fullscreen uploaded) scrot -d 1 $filename -e imgurbash2 ;;
    Section uploaded) scrot -s $filename -e imgurbash2 ;;
    *) exec "'${cmd}'" ;;
esac
