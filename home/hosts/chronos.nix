{ config, pkgs, ... }:
{
  imports = [ ../common/core.nix ];

  # Chronos-specific GUI packages
  home.packages = with pkgs; [
    beeper
    qbittorrent-enhanced
    obs-studio
    gimp-with-plugins
    webcord # discord wrapper with theming and tracker blocking
    ente-auth # 2FA
    azahar # 3ds emulator
  ];
  #link niri config
  home.file.".config/niri/config.kdl".source = ./niri.kdl;
}
