{ pkgs }:

pkgs.writeShellScriptBin "clipped-scrot" ''
  ${pkgs.scrot}/bin/scrot -s '/tmp/%F_%T_$wx$h.png' -e '${pkgs.xclip}/bin/xclip -selection clipboard -target image/png -i $f'
''
