# avalanche/flake.nix
{
  description = "Avalanche - Multi-host NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Future macOS support
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nvf,
      sops-nix,
      nix-darwin,
      ...
    }@inputs:

    let
      # Helper function to build a NixOS host
      # We hardcode mntn here since its the universal username
      mkHost =
        {
          hostname,
          system ? "x86_64-linux",
          extraModules ? [ ],
        }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };

          modules = [
            ./hosts/${hostname}

            # Inject SOPS
            inputs.sops-nix.nixosModules.sops
            # Inject Home Manager
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.mntn = import ./home/hosts/${hostname}.nix;
              home-manager.sharedModules = [
                inputs.noctalia.homeModules.default
                inputs.nvf.homeManagerModules.default
                inputs.sops-nix.homeManagerModules.default
              ];
            }
          ]
          ++ extraModules;
        };
    in
    {

      packages."x86_64-linux".default =
        (nvf.lib.neovimConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          modules = [ ./home/common/nvf-configuration.nix ];
        }).neovim;

      # hosts
      nixosConfigurations = {
        apollo = mkHost { hostname = "apollo"; };
        chronos = mkHost { hostname = "chronos"; };
        pheobe = mkHost { hostname = "pheobe"; };
        aether = mkHost { hostname = "aether"; };
        hephaestus = mkHost { hostname = "hephaestus"; };
      };

      # Future macOS host (commented out until you get a Mac)
      # darwinConfigurations = {
      #   macbook = nix-darwin.lib.darwinSystem {
      #     system = "aarch64-darwin";
      #     modules = [ ./hosts/macbook ./home/hosts/macbook.nix ];
      #   };
      # };
    };
}
