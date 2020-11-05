#!/usr/bin/env bash

prompt="-p Process to kill:"
selected="$(ps -a -u $USER | dmenu $prompt | awk '{print $1" "$4}')"; 

if [[ ! -z $selected ]]; then
    answer="$(echo -e "Yes\nNo" | \
        dmenu -i -p "$selected will be killed, are you sure?" \
        $lines $colors $font )"

    if [[ $answer == "Yes" ]]; then
        selpid="$(awk '{print $1}' <<< $selected)"; 
        kill -9 $selpid
    fi
fi

exit 0
