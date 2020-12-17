{ pkgs }:

pkgs.writeShellScriptBin "dmenu-audio" ''
  prompt="-p Choose audio output:"
  sink="$(echo \'Speaker\nHeadphones\' | ${pkgs.dmenu}/bin/dmenu $prompt)"
  case $sink in
    "Speaker")
      pacmd set-default-sink 0 && pkill -RTMIN+10 dwmblocks
      ;;
    "Headphones")
      pacmd set-default-sink 1 && pkill -RTMIN+10 dwmblocks
      ;;
  esac
  exit 0
''
