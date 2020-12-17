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

    accounts.email = {
        accounts = {
          gmail = {
            notmuch.enable = true;
            msmtp.enable = true;
            neomutt.enable = true;
            address = "mail@henn1nk.com";
            userName = "mail@henn1nk.com";
            flavor = "gmail.com";
            mbsync = {
                enable = true;
                create = "both";
#                expunge = "both";
                patterns = [ "*" "[!Gmail]*" "[Gmail/Sent Mail]" ];
            };
            realName = "${name}";
            passwordCommand = "${pkgs.pass}/bin/pass mail/mail@henn1nk.com";
          };
          main = {
            primary = true;
            address = "${email}";
            userName = "${email}";
            flavor = "plain";
            mbsync = {
              enable = true;
              create = "both";
#              expunge = "both";
              patterns = [ ];
            };
            realName = "${name}";
            imap.host = "imap.zoho.eu";
            smtp.host = "smtp.zoho.eu";
            passwordCommand = "${pkgs.pass}/bin/pass mail/${email}";
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
      zsh = {
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
          m = "neomutt";
          v = "vim";
          c = "clear";
          ls = "exa";
          l = "exa -abgHhl@ --git --color=always --group-directories-first";
          cat = "bat --paging=never";
          less = "bat --paging=always --style='changes --color=always";
          tree = "exa --tree --color=always";
        };
      };
    };

    xdg = {
        enable = true;
        configFile = {
            "feh/keys".source = ../../dotfiles/feh/keys;
            "newsboat".source = ../../programs/newsboat;
        };
    };

    xresources.extraConfig = builtins.readFile ../../dotfiles/xresources;

    xsession = {
      enable = true;
      windowManager.command = "dbus-run-session -- dwm";
      profileExtra = ''
        # xrdb $\{XDG_CONFIG_HOME:-$HOME/.config}/Xresources &
        dunst &
        udiskie &
        pgrep xflux || xflux -l 43.36 -g 1.26 &
        xset r rate 300 500 & 
        $HOME/.fehbg &
      '';
      #scriptPath = ".xinitrc";
    };
}
