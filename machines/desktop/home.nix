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
    imports = [
      ../../programs/dunst
      ../../programs/neovim/neovim.nix
    ];

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

    #programs.pass = {
    #    enable = true;
    #    package = pkgs.pass.withExtensions (e: [ e.pass.audit e.pass-otp e.pass-import ]);
    #};

    xdg = {
        enable = true;
        configFile = {
            "feh/keys".source = ../../dotfiles/feh/keys;
            "scripts".source = ../../scripts;
        };
    };

    xresources.extraConfig = builtins.readFile ../../dotfiles/xresources;

#    xsession = {
#      enable = true;
#      profileExtra = ''
#        # xrdb $\{XDG_CONFIG_HOME:-$HOME/.config}/Xresources &
#        phicom2 -b &
#        dunst &
#        udiskie &
#        pgrep xflux || xflux -l 43.36 -g 1.26 &
#        xset r rate 300 500 & 
#      '';
#      #scriptPath = ".xinitrc";
#    };
}
