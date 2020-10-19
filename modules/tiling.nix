{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        sxhkd
        polybar
        dunst
        picom
        materia-theme
        qt5.qtbase.gtk
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
            shadowOffsets = [ -10, -15 ];
            shadowOpacity = 0.8;
        };
    };

    xdg = {
        enable = true;
        configFile = {
            "sxhkd/sxhkdrc".source = ../../dotfiles/bspwm/sxhkdrc;
        };
    };
}