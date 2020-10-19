{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        sxhkd
        polybar
        dunst
        picom
        materia-theme
    ];

    services = {
        xserver = {
            displayManager.defaultSession = "none+bspwm";
            windowManager.bspwm.enable = true;
        };
        picom = {
            enable = true;
            fade = true;
            shadow = true;
            fadeDelta = 4;
        };
    };
}
