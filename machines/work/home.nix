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
      #windowManager.command = "dbus-run-session -- bspwm";
      windowManager = {
        bspwm = {
          enable = true;
          monitors = {
            HDMI1 = [ "1" "2" "3" "4" "5" ];
            HDMI2 = [ "6" "7" "8" "9" "0" ];
          };
          extraConfig = ''
            bspc config border_width = 2
          '';
          rules = {
            "Vim" = { desktop = "^2"; };
            "Enpass" = { desktop = "^3"; };
            "Music" = { desktop = "^4"; };
            "Gimp" = { desktop = "^5"; };
            "Inkscape" = { desktop = "^5"; };
            "VirtualBox Machine" = { desktop = "^6"; };
            "Franz" = { desktop = "^7"; };
            "Ticket" = { desktop = "^8"; };
            "Notion" = { desktop = "^9"; };
            "Firefox" = { desktop = "^10"; };
          };
        };
      };
      profileExtra = ''
        xrdb $\{XDG_CONFIG_HOME:-$HOME/.config}/Xresources &
        autocutsel &
        dunst &
        udiskie &
        pgrep xflux || xflux -l 43.36 -g 1.26 &
        xset r rate 300 500 & 
        $HOME/.fehbg &
        alacritty &
        surf https://www.notion.so/Pagisto-348782a7d5194a0187cba66689499e05 &
        surf https://ticket.pagisto.com/projects/config1/issues &
        firefox &
        franz &
        VBoxManage startvm "Windows 10" &
        Enpass &
      '';
    };

    services = {
      sxhkd = {
        enable = true;
        keybindings = {
          # wm independent
          "super + Return" = "alacritty"; # term
          "super + p" = "dmenu_run"; # launcher
          "super + shift + s" = "clipped-scrot";
          # bspwm
          "super + {_, shift + }w" = "bspc node -{c, k}"; # close and kill
          "super + m" = "bspc desktop -l next"; # alternate between tiled and monocle layout
          "super + y" = "bspc node newest.marked.local -n newest.!automatic.local"; # send newest marked node to newest preselected node
          "super + g" = "bspc node -s biggest.window"; # swap current node and biggest window
          "super + Escape" = "pkill -USR1 -x sxhkd";
          # bspwm: desktops
          "super + {1-9,0}" = "bspc desktop --focus ^{1-9,10}"; # switch to desktop
          "super + shift + {1-9,0}" = "bspc node --to-desktop ^{1-9,10}"; # move node to desktop
          # bspwm: state/flags
          "super + {t, shift + t, s, f}" = "bspc node -t {tiled, pseudo_tiled, floating, fullscreen}"; # set window state
          "super + ctrl + {m, x, y, z}" = "bspc node -g {marked, locked, sticky, private}"; # set node flags
        };
      };

      polybar = {
        enable = true;
        script = "polybar top &";
        package = pkgs.polybar.override {
          pulseSupport = true;
        };
        config = {
          "bar/top" = {
            monitor = "\${env:MONITOR:HDMI1}";
            width = "100%";
            height = "3%";
            radius = 0;
            font-2 = "Siji:pixelsize=12;2";
            modules-left = "bspwm";
            modules-center = "";
            modules-right = "sink volume date";
            scroll-up = "#bspwm.prev";
            scroll-down = "#bspwm.next";
          };

          "module/bspwm" = {
            type = "internal/bspwm";
            pin-workspaces = false;
            enable-click = true;
            enable-scroll = true;
            reverse-scroll = false;
            format-background = "#666666";
            format-foreground = "#FFFFFF";
            format-margin = 1;
            format-padding = 2;
          };

          "module/date" = {
            type = "internal/date";
            interval = 5;
            date = "%Y/%m/%d";
            time = "%H:%M";
            label = "%time% %date%";
            format-background = "#666666";
            format-foreground = "#FFFFFF";
            format-margin = 1;
            format-padding = 2;
          };

          "module/volume" = {
            type = "internal/pulseaudio";
            use-ui-max = true;
            interval = 5;
            format-background = "#666666";
            format-foreground = "#FFFFFF";
            format-margin = 1;
            format-padding = 2;
          };

          "module/sink" = {
            type = "custom/script";
            exec = "/run/current-system/sw/bin/pulseaudio-sink";
            click-left = "/run/current-system/sw/bin/pulseaudio-switch";
            interval = 5;
          };
        };
      };

      picom = {
        enable = true;
        shadowExclude = [ "class_i = 'polybar'" ];
      };

      dunst = {
        enable = true;
        settings = {
          global = {
            monitor = 0;
            geometry = "300x5-30+50";
            transparency = 10;
            frame_color = "#000000";
            font = "Droid Sans 9";
          };
          urgency_normal = {
            background = "#000000";
            foreground = "#FFFFFF";
            timeout = 10;
          };
        };
      };
    };
}
