{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];  boot.initrd.kernelModules = [ ];
  boot.kernelPackages = pkgs.linuxPackages_latest_hardened;
  boot.kernelModules = [ "coretemp" "k10temp" "i2c-dev" "amdgpu" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/a581225d-3199-46b9-8ee3-ba2c7d2eb115";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/EB5A-EC97";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/b10ce5ab-5f7d-412d-ba92-a55042fb1293"; }
    ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.video.hidpi.enable = lib.mkDefault true;
  hardware.opengl.extraPackages = with pkgs; [
    rocm-opencl-icd
    amdvlk
  ];
}
