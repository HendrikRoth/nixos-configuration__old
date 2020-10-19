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
        git
        gitfs

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

    services = {
        fail2ban.enable = true;
        timers = {
            syncmail = {
                Unit.Description = "Schedule syncing email and indexing with mu";
                Timer = {
                    Unit = "syncmail.service";
                    OnCalendar = "*:0/5";
                };
                Install.WantedBy = [ "timers.target" ];
            };
            cleanmail = {
                Unit.Description = "Schedule expunging email and indexing with mu";
                Timer = {
                    Unit = "cleanmail.service";
                    OnCalendar = "daily";
                }
                Install.WantedBy = [ "timers.target" ];
            };
        };
    };

    xdg = {
        enable = true;
        configFile = {
            "sxhkd/sxhkdrc".source = ../../dotfiles/sxhkdrc;
            "bspwm/bspwmrc".source = ./bspwmrc;
        };
    };
}