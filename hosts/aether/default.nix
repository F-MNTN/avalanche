{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common
    # ../../modules/desktop # Uncomment if it's a desktop
    inputs.noctalia.nixosModules.default
  ];

  networking.hostName = "aether";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = false;
  services.printing.enable = true;

  system.stateVersion = "25.11"; # Adjust to your current NixOS version
}
