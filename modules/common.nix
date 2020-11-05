{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        # shell
        zsh
        tmux
        thefuck
        bat
        exa

        # languages
        python3

        # productivity
        fzf
        gist
        neovim
        nnn
        git
        gitfs
        w3m
        htop
        translate-shell
        calc

        # mail
        neomutt

        # calendar
        khal
        vdirsyncer

        # secrets
        gnupg
        pass

        # compression
        zip
        p7zip
        unzip
        unrar
        xz

        # file transfer
        wget
        rsync

        # development
        stdenv
    ];

    fonts.fonts = with pkgs; [
        noto-fonts
        fira-code
        fira-code-symbols
        corefonts
    ];

    hardware.bluetooth.enable = true;

    nixpkgs.config.allowUnfree = true;
    i18n.defaultLocale = "en_US.UTF-8";
    time.timeZone = "Europe/Berlin";

    programs = {
        tmux = {
            enable = true;
        };

        zsh = {
            enable = true;
            enableCompletion = true;
            autosuggestions.enable = true;
            syntaxHighlighting.enable = true;
            ohMyZsh = {
                enable = true;
                theme = "robbyrussell";
                plugins = [ "git" "sudo" "tmux" "thefuck" "extract" "docker" ];
            };
            shellAliases = {
              v = "vim";
              c = "clear";
              ls = "exa";
              l = "exa -abgHhl@ --git --color=always --group-directories-first";
              cat = "bat --paging=never";
              less = "bat --paging=always --style='changes --color=always";
              tree = "exa --tree --color=always";
            };
            shellInit = "";
        };
    };

    users.defaultUserShell = pkgs.zsh;
    users.users.hendrik = {
        isNormalUser = true;
        extraGroups = [ "wheel" "sudo" "audio" "disk" "networkmanager" ];
        shell = pkgs.zsh;
    };

    services = {
        fail2ban.enable = true;
        openssh.enable = true;
        blueman.enable = true;
    };
}
