{ config, pkgs, inputs, ... }: {
  imports = [
    ./hardware-configuration.nix

    # Shared system baseline
    ../../modules/common
    ../../modules/T480
    ../../modules/audio
    inputs.noctalia.nixosModules.default
  ];

  # --- Host-Specific Settings ---
  networking.hostName = "chronos";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = false;
  services.printing.enable = true;

  # custom options
  avalanche.bluetooth = {
    enable = true;
    intelCoexFix = true;
  };


  system.stateVersion = "25.11";
}
