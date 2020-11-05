#!/usr/bin/env bash

prompt="Translate:"
origin="$(echo '' | dmenu $prompt)"
result="$(trans -b $origin | tr -d '\n')"
notify-send "Translated" "$origin to $result"
xsel $result

exit 0
