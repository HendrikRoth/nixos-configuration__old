{ config, pkgs, ... }:

{
    imports = [
      ../programs/dmenu
      #../programs/st
    ];

    environment.systemPackages = with pkgs; [
        alacritty
        dunst
        picom
        materia-theme
        dmenu
        surf
        sxhkd
        xsel
        libnotify
        scrot
        imgurbash2
        zscroll
        (callPackage ../programs/onlineip {})
        (callPackage ../programs/clipped-scrot {})
        (callPackage ../programs/dmenu-calc {})
        (callPackage ../programs/dmenu-mail {})
        (callPackage ../programs/dmenu-power {})
        (callPackage ../programs/dmenu-audio {})
        #(callPackage ../programs/dmenu-scrot {})
        (callPackage ../programs/dmenu-playerctl {})
        (callPackage ../programs/dmenu-translate {})
        (callPackage ../programs/dmenu-wallpaper {})
        (callPackage ../programs/dmenu-web-search {})
        (callPackage ../programs/dmenu-man-search {})
        (callPackage ../programs/pulseaudio-switch {})
        (callPackage ../programs/pulseaudio-sink {})
        (callPackage ../programs/spotify-status {})
        (callPackage ../programs/spotify-scroll {})
    ];

    services = {
        xserver = {
            displayManager.defaultSession = "none+bspwm";
            windowManager.bspwm.enable = true;
        };
    };
}
