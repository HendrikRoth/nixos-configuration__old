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
        prezto = {
          enable = true;
          prompt = {
            theme = "pure";
          };
          #tmux = {
          #  autoStartLocal = true;
          #  autoStartRemote = true;
          #};
          pmodules = [ "git" "tmux" "docker" "prompt" ];
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
      alacritty = {
        enable = true;
        settings = {
          window = {
            padding = {
              x = 5;
              y = 5;
            };
          };
          colors = {
            primary = {
              background = "#ffffff";
              foreground = "#000000";
            };
            normal = {
              black = "#696c77";
              red = "#e45649";
              green = "#50a14f";
              yellow = "#c18401";
              blue = "#4078f2";
              magenta = "#a626a4";
              cyan = "#0184bc";
              white = "#a0a1a7";
            };
          };
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
        xrdb $\{XDG_CONFIG_HOME:-$HOME/.config}/Xresources &
        dwmblocks &
        autocutsel &
        dunst &
        udiskie &
        pgrep xflux || xflux -l 43.36 -g 1.26 &
        xset r rate 300 500 & 
        $HOME/.fehbg &
        VBoxManage startvm "Windows 10" &
        firefox &
        franz &
        surf https://www.notion.so/Pagisto-348782a7d5194a0187cba66689499e05 &
        surf https://ticket.pagisto.com/projects/config1/issues &
      '';
    };
}
