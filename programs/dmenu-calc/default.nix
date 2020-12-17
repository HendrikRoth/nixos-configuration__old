{ pkgs }:

pkgs.writeShellScriptBin "dmenu-calc" ''
  prompt="-p Calculate:"
  origin="$(echo \'\' | ${pkgs.dmenu}/bin/dmenu $prompt)"
  result="$($origin | ${pkgs.calc}/bin/calc -p | tr -d '\n')"
  ${pkgs.libnotify}/bin/notify-send "$origin = $result"
  ${pkgs.xsel}/bin/xsel < $result
  exit 0
''
