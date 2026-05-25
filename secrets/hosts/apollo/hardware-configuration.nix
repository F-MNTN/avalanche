{ config, lib, pkgs, modulesPath, ... }: {
  imports =[ 
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" ={ 
    device = "/dev/disk/by-uuid/c6c2b5aa-5cad-4b86-b94f-010c13c45494";
    fsType = "ext4";
  };

  fileSystems."/boot" ={ 
    device = "/dev/disk/by-uuid/97E5-B07A";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" "nofail"];
  };

  fileSystems."/mnt/bulk" =
    { device = "/dev/disk/by-uuid/ef2276ef-9931-49ff-82ef-cb0f131646dc";
      fsType = "ext4";
    };

  swapDevices =[ { device = "/dev/disk/by-uuid/1032bedb-030e-4c99-8256-e271b13faa03";}];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
