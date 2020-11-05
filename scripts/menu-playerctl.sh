#!/usr/bin/env bash

selected="$(playerctl -l | dmenu -l 10 -p "Select:" | tr -d '\n')"
playerctl --player=$selected play-pause

exit 0
