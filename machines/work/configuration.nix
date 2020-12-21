{ config, pkgs, ...}:
{
    imports = [
        ./hardware-configuration.nix
        ../../modules/common.nix
        ../../modules/desktop.nix
        ../../modules/tiling.nix
    ];

    environment.systemPackages = with pkgs; [
        chromium
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
