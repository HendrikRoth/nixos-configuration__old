#!/usr/bin/env bash

text="$(echo | dmenu -p "Mail Text:")"
subject="$(echo | dmenu -p "Mail Subject:")"
address="$(echo | dmenu -p "Mail Address:")"

if [ $address != "" ]; then
    echo $text | mutt -s $subject $address && notify-send "Mail sent to $address"
else
    notify-send "Mail" "You didn't insert any address."
fi

exit 0
