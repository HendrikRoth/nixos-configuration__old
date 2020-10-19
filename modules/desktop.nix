{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        # art
        inkscape
        gimp
        feh

        # cad
        blender
        freecad

        # network
        firefox
        neomutt
        franz

        # media
        mpv
        spotify-tui
        playerctl

        # secrets
        enpass

        # terminal
        kitty
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
        layout = "us";
        xkbOptions = "eurosign:e";
        displayManager.slim.enable = true;
    };
}