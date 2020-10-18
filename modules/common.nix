{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        # shell
        zsh
        tmux

        # productivity
        fzf
        gist
        neovim
        lf

        # compression
        zip
        p7zip
        unzip
        unrar

        # file transfer
        wget
        rsync
    ];

    fonts.fonts = with pkgs; [
        corefonts
    ];

    services.fail2ban.enable = true;
    nixpkgs.config.allowUnfree = true;
    i18n.defaultLocale = "en_US.UTF-8";
    timezone = "Europe/Berlin";

    programs = {
        tmux.enable = true;
        zsh = {
            enable = true;
            enableCompletion = true;
            autosuggestions.enable = true;
            syntaxHighlighting.enable = true;
        };
        fzf.enable = true;
    };

    users.mutableUsers = false;
    users.users.hendrik = {
        isNormalUser = true;
        extraGroups = [ "wheel" "sudo" "audio" "disk" "networkmanager" ];
        shell = pkgs.zsh;
    };
}