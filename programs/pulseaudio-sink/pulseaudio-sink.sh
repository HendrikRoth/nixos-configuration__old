sink=$(/run/current-system/sw/bin/pactl list short | grep RUNNING | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,')
[[ $sink -eq 0 ]] && echo "" || echo ""
