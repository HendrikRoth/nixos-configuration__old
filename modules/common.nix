{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        # shell
        zsh
        tmux

        # languages
        python3

        # productivity
        fzf
        gist
        neovim
        lf
        git
        gitfs

        # mail
        neomutt

        # calendar
        khal
        vdirsyncer

        # secrets
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
    ];

    fonts.fonts = with pkgs; [
        corefonts
    ];

    nixpkgs.config.allowUnfree = true;
    i18n.defaultLocale = "en_US.UTF-8";
    time.timeZone = "Europe/Berlin";

    programs = {
        tmux.enable = true;
        zsh = {
            enable = true;
            enableCompletion = true;
            autosuggestions.enable = true;
            syntaxHighlighting.enable = true;
        };
    };

    users.users.hendrik = {
        isNormalUser = true;
        extraGroups = [ "wheel" "sudo" "audio" "disk" "networkmanager" ];
        shell = pkgs.zsh;
    };

    services = {
        fail2ban.enable = true;
        openssh.enable = true;
    };
}
