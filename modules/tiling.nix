{ config, pkgs, ... }:

{
    imports = [
      ../programs/dmenu
#      ../programs/dmenu-calc
#      ../programs/dmenu-mail
#      ../programs/dmenu-power
#      ../programs/dmenu-scrot
#      ../programs/dmenu-playerctl
#      ../programs/dmenu-translate
#      ../programs/dmenu-wallpaper
#      ../programs/dmenu-web-search
#      ../programs/dmenu-man-search
      ../programs/st
    ];

    environment.systemPackages = with pkgs; [
        dunst
        picom
        materia-theme
        dmenu
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
        st
        xsel
        (callPackage ../programs/onlineip {})
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
