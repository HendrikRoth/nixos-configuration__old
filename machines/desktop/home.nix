{ pkgs, ...}:

let
    # personal information
    name = "Hendrik Roth";
    mail = "hi@hendrikroth.com";
    username = "hendrik";
    githubUsername = "HendrikRoth";

    # paths
    homedir = "/home/hendrik/";
    dotfilesdir = "dotfiles";
    scriptsdir = "scripts";
    maildir = "mail";

in
{
    imports = [
        ../../modules/neovim.nix
    ];

    home = {
        file.".zshrc".source = ../../dotfiles/zsh/zshrc
        username = "${username}";
        homeDirectory = "${homedir}";
        stateVersion = "20.09"
        sessionVariables = {
            EDITOR = "nvim";
            MUSICCLIENT = "spotify-tui";
            MEDIACLIENT = "mpc";
            BROWSER = "firefox";
        };
    };

    accounts.email = {
        mailDirPath = "${homedir}${maildir}";
        accounts = {
            gmail = {
                address = "mail@henn1nk.com";
                userName = "mail@henn1nk.com";
                flavor = "gmail";
                mbsync = {
                    enable = true;
                    expunge = "both";
                    patterns = [ "*" "[!Gmail]*" "[Gmail/Sent Mail]" ];
                };
                realName = "${name}";
            };
            main = {
                address = "${email}";
                userName = "";
                flavor = "imap";
                mbsync = {
                    enable = true;
                    expunge = "both";
                    patterns = [ ];
                };
                realName = "${email}";
            };
        };
    };

    programs = {
        home-manager = {
            enable = true;
        };
        git = {
            userName = "${name}";
            userEmail = "${email}";
        };
    };

    xdg = {
        enable = true;
        configFile = {
            "feh/keys".source = ../../dotfiles/feh/keys;
            "picom.conf".source = ../../dotfiles/picom.conf;

            "bspwm/bspwmrc".source = ./dotfiles/bspwmrc;
            "khal/config".source = ./dotfiles/khal;
        };
    };
}