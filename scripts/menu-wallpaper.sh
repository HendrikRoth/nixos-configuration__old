#!/usr/bin/env bash

folder=${WALLPAPER_DIR:-"~/.wallpapers"}
prompt="-p Select:"
selected="$(ls $folder | dmenu $prompt)"
feh --bg-fill $folder/$selected

exit 0
