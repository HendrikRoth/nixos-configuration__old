{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        sxhkd
    ];

    services.xserver = {
        displayManager.defaultSession = "none+bspwm";
        windowManager.bspwm.enable = true;
    };
}