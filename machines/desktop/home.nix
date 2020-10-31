{ pkgs, ...}:

let
    # personal information
    name = "Hendrik Roth";
    email = "hi@hendrikroth.com";
    username = "hendrik";
    githubUsername = "HendrikRoth";

    # paths
    homedir = "/home/hendrik/";
    dotfilesdir = "dotfiles";
    scriptsdir = "scripts";
    maildir = "mail";

in
{
    programs = {
        home-manager = {
            enable = true;
        };
        git = {
            userName = "${name}";
            userEmail = "${email}";
        };
    };

    home = {
        username = "${username}";
        homeDirectory = "${homedir}";
        stateVersion = "20.09";
        sessionVariables = {
            EDITOR = "nvim";
            MUSICCLIENT = "spotify-tui";
            MEDIACLIENT = "mpc";
            BROWSER = "firefox";
        };
    };

    imports = [
        ../../modules/neovim.nix
    ];

#    accounts.email = {
#        mailDirPath = "${homedir}${maildir}";
#        accounts = {
#            gmail = {
#                address = "mail@henn1nk.com";
#    		 userName = "mail@henn1nk.com";
#                flavor = "gmail";
#                mbsync = {
#                    enable = true;
#                    expunge = "both";
#                    patterns = [ "*" "[!Gmail]*" "[Gmail/Sent Mail]" ];
#                };
#                realName = "${name}";
#            };
#            main = {
#                address = "${email}";
#                userName = "";
#                flavor = "imap";
#                mbsync = {
#     	 	     enable = true;
#                    expunge = "both";
#                    patterns = [ ];
#                };
#                realName = "${email}";
#            };
#        };
#    };

     programs.zsh = {
        enable = true;
        enableCompletion = true;
        enableAutosuggestions = true;
        autocd = true;
        defaultKeymap = "viins";
        oh-my-zsh = {
            enable = true;
            theme = "robbyrussell";
            plugins = [ "git" "sudo" "tmux" "thefuck" "extract" "docker" ];
        };
        shellAliases = {
          n = "nnn";
          v = "vim";
          c = "clear";
          ls = "exa";
          l = "exa -abgHhl@ --git --color=always --group-directories-first";
          cat = "bat --paging=never";
          less = "bat --paging=always --style='changes --color=always";
          tree = "exa --tree --color=always";
        };
    };

    programs.pass = {
        enable = true;
        package = pkgs.pass.withExtensions (e: [ e.pass.audit e.pass-otp e.pass-import ]);
    };

    xdg = {
        enable = true;
        configFile = {
            "feh/keys".source = ../../dotfiles/feh/keys;
            "sxhkd/sxhkdrc".source = ../../dotfiles/sxhkd/sxhkdrc;
            "rofi/config.rasi".source = ../../dotfiles/rofi/config.rasi;
            "polybar/config".source = ../../dotfiles/polybar/config;
            "polybar/launch.sh".source = ../../dotfiles/polybar/launch.sh;

            "bspwm/bspwmrc".source = ./dotfiles/bspwmrc;
            "khal/config".source = ./dotfiles/khal;
        };
    };
}
