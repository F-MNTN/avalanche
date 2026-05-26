{ config, pkgs, inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/common
    inputs.noctalia.nixosModules.default
  ];

  networking.hostName = "aether";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = false;
  services.printing.enable = true;

  # --- Home Manager Bridge ---
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "bak";
    users.mntn = import ../../home/hosts/aether.nix;
  };

  system.stateVersion = "25.11"; # Adjust to your current NixOS version
}
