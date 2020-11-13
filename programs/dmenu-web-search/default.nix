{ pkgs }:

pkgs.writeShellScriptBin "dmenu-web-search" ''
  browser=${BROWSER:-firefox}
  url="https://searx.monicz.pl/"
  prompt="-p Websearch:"
  choice="$(echo \'\' | ${pkgs.dmenu}/bin/dmenu $prompt)" || exit 1
  $browser "$url?q=$choice"
  exit 0
''
