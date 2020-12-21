{ pkgs }:

pkgs.writeShellScriptBin "dmenu-scrot" (builtins.readFile ./dmenu-scrot.sh)
