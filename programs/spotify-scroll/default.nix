{ pkgs }:

pkgs.writeShellScriptBin "polybar-spotify-scroll" ''
  zscroll -l 30 \
    --delay 0.1 \
    --scroll-padding "  " \
    --match-command "/run/current-system/sw/bin/spotify-status --status" \
    --match-text "Playing" "--scroll 1" \
    --match-text "Paused" "--scroll 0" \
    --update-check true "/run/current-system/sw/bin/spotify-status" &

  wait
''
