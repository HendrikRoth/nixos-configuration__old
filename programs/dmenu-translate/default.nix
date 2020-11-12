with import <nixpkgs> {};

let
  dmenu-translate = pkgs.writeShellScriptBin "dmenu-translate" ''
prompt="Translate:"
origin="$(echo \'\' | ${pkgs.dmenu}/bin/dmenu $prompt)"
result="$(${pkgs.trans}/bin/trans -b $origin | tr -d '\n')"
${pkgs.notify-send}/bin/notify-send "Translated" "$origin to $result"
${pkgs.xsel}/bin/xsel $result
exit 0
    '';

in
stdenv.mkDerivation rec {
  name = "test-environment";
  buildInputs = [ dmenu-translate ];
}
