with import <nixpkgs> {};

let
  dmenu-wallpaper = pkgs.makeShellScriptBin "dmenu-wallpaper" ''
folder=${WALLPAPER_DIR:-"~/.wallpapers"}
prompt="-p Select:"
selected="$(ls $folder | ${pkgs.dmenu}/bin/dmenu $prompt)"
${pkgs.feh}/bin/feh --bg-fill $folder/$selected
exit 0
    '';

in
stdenv.mkDerivation rec {
  name = "test-environment";
  buildInputs = [ dmenu-wallpaper ];
}
