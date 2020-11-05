#!/usr/bin/env bash

prompt="-p Calculate:"
origin="$(echo '' | dmenu $prompt)"
result="$($origin | calc -p | tr -d '\n')"
notify-send "Calculated" "$origin = $result"
xsel $result

exit 0
