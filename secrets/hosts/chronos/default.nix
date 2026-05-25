{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix

    # Shared system baseline
    ../../modules/common
    ../../modules/T480
    inputs.noctalia.nixosModules.default
  ];

  # --- Apollo-Specific Settings ---
  networking.hostName = "chronos";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = false;
  services.printing.enable = true;

  # --- SOPS ---
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/mntn/.config/sops/age/keys.txt";

    secrets = {
      "github_email" = { };
      "wifi/eduroam/email" = { };
      "wifi/eduroam/password" = { };
    };
  };

  # --- Home Manager Bridge ---
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "bak";
    users.mntn = import ../../home/hosts/chronos.nix;
  };

  system.stateVersion = "25.11";
}
