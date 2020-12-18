{ config, pkgs, ...}:
{
#    nix.extraOptions = ''
#        plugin-files = ${pkgs.nix-plugins_4.override { nix = config.nix.package; }}/lib/nix/plugins/libnix-extra-builtins.so
#    '';

    #deployment.keys.secrets.text = builtins.extraBuiltins.pass "secrets";

    nixpkgs.config.packageOverrides = pkgs: {
      nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        inherit pkgs;
      };
    };

    imports = [
        ./hardware-configuration.nix
        ../../modules/common.nix
        ../../modules/desktop.nix
        ../../modules/tiling.nix
    ];

    environment.systemPackages = with pkgs; [
        chromium
        (nur.repos.pn.dwmblocks.overrideAttrs (oldAttrs: {
          patches = [
            ../../programs/dwmblocks/1.diff
          ];
        }))
    ];

    boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
    };

    networking = {
        hostName = "desktop";
        useDHCP = false;
        interfaces.wlp1s0.useDHCP = true;
        networkmanager.enable = true;
    };

    services.openssh.enable = true;
    services = {
      xserver = {
        videoDrivers = [ "intel" ];
        xrandrHeads = [ "HDMI1" "HDMI2" ];
      };
      printing = {
        enable = true;
        drivers = [ pkgs.gutenprint ];
        webInterface = true;
      };
    };

    system = {
        stateVersion = "20.09";
        autoUpgrade = {
            enable = true;
            allowReboot = false;
        };
    };
}
