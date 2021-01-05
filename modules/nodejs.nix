{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
      #nodejs-12_x
      nodejs-14_x
      nodePackages_latest.node-gyp
      nodePackages_latest.typescript
    ];
}
