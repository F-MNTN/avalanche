# hosts/apollo/default.nix
{ config, pkgs, inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    
    # Shared system baseline
    ../../modules/common
    
    inputs.noctalia.nixosModules.default
  ];

  # --- Apollo-Specific Settings ---
  networking.hostName = "apollo";

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
    users.mntn = import ../../home/hosts/apollo.nix;
  };


  system.stateVersion = "25.11";
}
