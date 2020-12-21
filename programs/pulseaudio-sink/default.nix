{ pkgs }:

pkgs.writeShellScriptBin "pulseaudio-sink" ''
  sink=$(${pkgs.pulseaudio}/bin/pactl list short | ${pkgs.busybox}/bin/grep RUNNING | ${pkgs.busybox}/bin/sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,')
  [[ $sink -eq 0 ]] && echo "" || echo ""
''
