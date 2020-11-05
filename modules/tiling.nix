{ config, pkgs, ... }:

{
    imports = [
      ../programs/dmenu
      ../programs/dwm
      ../programs/st
    ];

    environment.systemPackages = with pkgs; [
        dunst
        picom
        materia-theme
        dmenu
        dwm
        st
        xsel
    ];

    services = {
        xserver = {
            displayManager.defaultSession = "none+dwm";
            windowManager.dwm.enable = true;
        };
        picom = {
            enable = true;
            fade = true;
            shadow = true;
            fadeDelta = 2;
        };
    };
}
