with import <nixpkgs> {};

let
  dmenu-web-search = pkgs.makeShellScriptBin "dmenu-web-search" ''
browser=${BROWSER:-firefox}
url="https://searx.monicz.pl/"
prompt="-p Websearch:"
choice="$(echo \'\' | ${pkgs.dmenu}/bin/dmenu $prompt)" || exit 1
$browser "$url?q=$choice"
exit 0
    '';

in
stdenv.mkDerivation rec {
  name = "test-environment";
  buildInputs = [ dmenu-web-search ];
}
