{ pkgs }:

pkgs.writeShellScriptBin "dmenu-wallpaper" ''
  folder=/home/hendrik/.wallpapers
  prompt="-p Select:"
  selected="$(ls $folder | ${pkgs.dmenu}/bin/dmenu $prompt)"
  ${pkgs.feh}/bin/feh --bg-fill $folder/$selected
  exit 0
''
