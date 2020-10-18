{ config, pkgs, ...}:
{
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
    };

    networking = {
        useDHCP = false;
        interfaces.wlp10s0.useDHCP = true;
        networkmanager.enable = true;
    };

    services.openssh.enable = true;

    system = {
        stateVersion = "20.09";
        autoUpgrade = {
            enable = true;
            allowReboot = false;
        };
    };
}