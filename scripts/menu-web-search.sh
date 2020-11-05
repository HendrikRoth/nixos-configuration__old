#!/usr/bin/env bash

browser=${BROWSER:-firefox}
url="https://searx.monicz.pl/"
prompt="-p Websearch:"
choice="$(echo '' | dmenu $prompt)" || exit 1
$browser "$url?q=$choice"

exit 0
