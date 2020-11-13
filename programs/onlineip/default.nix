{ pkgs }: 

pkgs.writeShellScriptBin "onlineip" ''
  ${pkgs.curl}/bin/curl -s http://httpbin.org/get \
    | ${pkgs.jq}/bin/jq --raw-output .origin
''
