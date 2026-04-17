{ config, pkgs, ... }:
{
  imports = [ ../common/core.nix ];

  # Apollo-specific GUI packages
  home.packages = with pkgs; [
    sioyek # pdf reader
    beeper
    qbittorrent-enhanced
    grim # screenshot tool
    obs-studio
    gimp-with-plugins
    localsend
  ];

  services.openssh.enable = true;
  #link niri config
  home.file.".config/niri/config.kdl".source = ./niri.kdl;
}
