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

    boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
    };

    networking = {
        hostName = "desktop";
        useDHCP = false;
        interfaces.wlp6s0.useDHCP = true;
        networkmanager.enable = true;
    };

    services.openssh.enable = true;
    services.xserver.videoDrivers = [ "amdgpu" ];

    system = {
        stateVersion = "20.09";
        autoUpgrade = {
            enable = true;
            allowReboot = false;
        };
    };
}
