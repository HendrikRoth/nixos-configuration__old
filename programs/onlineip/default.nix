{ stdenv, pkgs }:

let
  onlineip = pkgs.writeShellScriptBin "onlineip" ''
    ${pkgs.curl}/bin/curl -s http://httpbin.org/get \
      | ${pkgs.jq}/bin/jq --raw-output .origin
  '';

in
stdenv.mkDerivation rec {
  name = "onlineip-${version}";
  version = "1.0.0";
  installPhase = ''
    mkdir -p $out/bin
    cp ${onlineip} $out/bin/onlineip
    chmod +x $out/bin/onlineip
  '';
}
