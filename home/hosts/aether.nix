{ config, pkgs, ... }: {
  imports = [ ../common/core.nix ];
  
  # aether-specific GUI packages
  home.packages = with pkgs; [

  ];
  home.file.".config/niri/config.kdl".source = ./niri.kdl;
}
