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
        (dwm.overrideAttrs (oldAttrs: {
          patches = [
            ../programs/dwm/1-pertag.diff
            ../programs/dwm/2-scratchpad.diff
            ../programs/dwm/3-combo.diff
            ../programs/dwm/4-centretitle.diff
            ../programs/dwm/5-sticky.diff
            ../programs/dwm/6-deck.diff
            ../programs/dwm/7-columns.diff
            ../programs/dwm/8-xresources.diff
            ../programs/dwm/9-alpha.diff
          ];
          postPatch = let
            configFile = pkgs.writeText "config.def.h" (builtins.readFile ../programs/dwm/config.h);
          in
            ''cp ${configFile} config.def.h'';
        }))
        #st
        xsel
        libnotify
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
            fadeDelta = 1;
        };
    };
}
