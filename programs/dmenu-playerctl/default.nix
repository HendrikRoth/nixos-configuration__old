with import <nixpkgs> {};

let
  dmenu-playerctl = pkgs.writeShellScriptBin "dmenu-playerctl" ''
selected="$(${pkgs.playerctl}/bin/playerctl -l | ${pkgs.dmenu}/bin/dmenu -l 10 -p "Select:" | tr -d '\n')"
${pkgs.playerctl}/bin/playerctl --player=$selected play-pause
exit 0
    '';

in
stdenv.mkDerivation rec {
  name = "test-environment";
  buildInputs = [ dmenu-playerctl ];
}
