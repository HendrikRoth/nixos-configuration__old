{ pkgs }:

pkgs.writeShellScriptBin "dmenu-translate" ''
  prompt="Translate:"
  origin="$(echo \'\' | ${pkgs.dmenu}/bin/dmenu $prompt)"
  result="$(${pkgs.translate-shell}/bin/trans -b $origin | tr -d '\n')"
  ${pkgs.libnotify}/bin/notify-send "Translated" "$origin to $result"
  ${pkgs.xsel}/bin/xsel $result
  exit 0
''
