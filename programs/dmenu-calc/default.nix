with import <nixpkgs> {};

let
  dmenu-calc = pkgs.writeShellScriptBin "dmenu-calc" ''
prompt="-p Calculate:"
origin="$(echo \'\' | ${pkgs.dmenu}/bin/dmenu $prompt)"
result="$($origin | ${pkgs.calc}/bin/calc -p | tr -d '\n')"
${pkgs.notify-send}/bin/notify-send "Calculated" "$origin = $result"
${pkgs.xsel}/bin/xsel $result
exit 0
  '';
in
stdenv.mkDerivation rec {
  name = "test-environment";
  buildInputs = [ dmenu-calc ]; 
}
