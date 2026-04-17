#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Automatically resolve the directory of the flake
FLAKE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOSTS_DIR="$FLAKE_DIR/hosts"
HOME_HOSTS_DIR="$FLAKE_DIR/home/hosts"

echo "❄️  NixOS Flake Host Setup ❄️"
echo "------------------------------"
echo "1) Create a NEW host"
echo "2) Reinstall/Update an EXISTING host"
echo "------------------------------"
read -p "Select an option [1-2]: " OPTION

if [ "$OPTION" == "1" ]; then
    # --- CREATE NEW HOST ---
    read -p "Enter the new hostname: " HOSTNAME

    if [ -d "$HOSTS_DIR/$HOSTNAME" ]; then
        echo "❌ Error: Host '$HOSTNAME' already exists."
        exit 1
    fi

    echo "Creating structure for $HOSTNAME..."
    mkdir -p "$HOSTS_DIR/$HOSTNAME"

    # Generate hardware config based on the current machine's hardware
    echo "Generating hardware-configuration.nix..."
    nixos-generate-config --show-hardware-config > "$HOSTS_DIR/$HOSTNAME/hardware-configuration.nix"

    # Create boilerplate default.nix for the new host
    cat > "$HOSTS_DIR/$HOSTNAME/default.nix" <<EOF
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common
    # ../../modules/desktop # Uncomment if it's a desktop
    inputs.noctalia.nixosModules.default
  ];

  networking.hostName = "$HOSTNAME";

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
    users.mntn = import ../../home/hosts/$HOSTNAME.nix;
  };

  system.stateVersion = "25.11"; # Adjust to your current NixOS version
}
EOF

    # Create boilerplate home-manager config
    cat > "$HOME_HOSTS_DIR/$HOSTNAME.nix" <<EOF
{ config, pkgs, ... }: {
  imports = [ ../common/core.nix ];
  
  # $HOSTNAME-specific GUI packages
  home.packages = with pkgs; [

  ];
  home.file.".config/niri/config.kdl".source = ./niri.kdl;
}
EOF

    echo "✅ Scaffolded $HOSTNAME."
    echo "⚠️  IMPORTANT: Don't forget to add '$HOSTNAME' to your outputs in flake.nix!"
    echo "Press Enter to continue to deployment, or Ctrl+C to edit your flake.nix first."
    read -r

elif [ "$OPTION" == "2" ]; then
    # --- REINSTALL EXISTING HOST ---
    echo "Available hosts:"
    
    # Read directories into an array safely
    mapfile -t HOST_ARRAY < <(ls -1 "$HOSTS_DIR")
    
    select HOSTNAME in "${HOST_ARRAY[@]}"; do
        if [ -n "$HOSTNAME" ]; then
            echo "Selected: $HOSTNAME"
            break
        else
            echo "Invalid selection. Try again."
        fi
    done

    echo "------------------------------"
    read -p "Do you want to regenerate hardware-configuration.nix for this machine? (y/N): " REGEN_HW
    if [[ "$REGEN_HW" =~ ^[Yy]$ ]]; then
        echo "Regenerating hardware-configuration.nix..."
        nixos-generate-config --show-hardware-config > "$HOSTS_DIR/$HOSTNAME/hardware-configuration.nix"
        echo "✅ Hardware config updated."
        echo "⚠️  Remember to stage the new hardware-configuration.nix in git before deploying!"
    fi
else
    echo "Invalid option. Exiting."
    exit 1
fi

# --- DEPLOYMENT PHASE ---
echo ""
echo "🚀 How would you like to deploy $HOSTNAME?"
echo "1) nixos-rebuild switch (Updating a live, running system)"
echo "2) nixos-install        (Installing to a freshly mounted disk at /mnt)"
echo "3) Exit                 (Do nothing right now)"
echo "------------------------------"
read -p "Select an option [1-3]: " DEPLOY_OPT

if [ "$DEPLOY_OPT" == "1" ]; then
    echo "Running nixos-rebuild switch --flake .#$HOSTNAME..."
    sudo nixos-rebuild switch --flake "$FLAKE_DIR#$HOSTNAME"
elif [ "$DEPLOY_OPT" == "2" ]; then
    echo "Running nixos-install --flake .#$HOSTNAME..."
    sudo nixos-install --flake "$FLAKE_DIR#$HOSTNAME"
else
    echo "Exiting. You can deploy manually later using:"
    echo "sudo nixos-rebuild switch --flake .#$HOSTNAME"
fi
