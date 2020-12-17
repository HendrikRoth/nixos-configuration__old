{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        # art
        inkscape
        gimp

        # cad
        blender
        freecad

        # productivity
        zathura
        libreoffice
        enpass

        # network
        firefox
        franz

        # media
        mpv
        spotify-tui
        playerctl
        ncpamixer

        # terminal
        kitty

        # screen
        feh
        xflux
        xclip
        scrot

        # utils
        udiskie

        # theme
        ant-theme
        flat-remix-icon-theme

        # misc
        anydesk
    ];

    programs.tmux = {
        enable = true;
        keyMode = "vi";
        clock24 = true;
        escapeTime = 100;
        terminal = "screen-256color";
        newSession = true;
        shortcut = "a";
    };

    sound.enable = true;

    hardware = {
        pulseaudio = {
            enable = true;
            support32Bit = true;
            package = pkgs.pulseaudioFull;
            extraModules = [ pkgs.pulseaudio-modules-bt ];
        };
        bluetooth = {
            enable = true;
            package = pkgs.bluezFull;
            config.General.Enable = "Source,Sink,Media,Socket";
        };
    };

    services.xserver = {
        enable = true;
        layout = "eu";
        xkbOptions = "caps:escape";
        displayManager.lightdm.enable = true;
    };

    services.dbus.packages = [ pkgs.at_spi2_core ];
}
