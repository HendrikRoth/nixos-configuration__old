{ config, pkgs, ... }:

{
    imports = [
      ../programs/dwm
      ../programs/st
      ../programs/dmenu
    ];

    environment.systemPackages = with pkgs; [
        sxhkd
        polybar
        dunst
        picom
        materia-theme
        rofi
        st
        dwm
        dmenu
        xsel
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
            fadeDelta = 2;
        };
    };
}
