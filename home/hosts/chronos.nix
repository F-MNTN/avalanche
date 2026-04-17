{ config, pkgs, ... }:
{
  imports = [ ../common/core.nix ];

  # Chronos-specific GUI packages
  home.packages = with pkgs; [
    beeper
    qbittorrent-enhanced
    obs-studio
    gimp-with-plugins
    discord
    ente-auth # 2FA
  ];
  #link niri config
  home.file.".config/niri/config.kdl".source = ./niri.kdl;
}
