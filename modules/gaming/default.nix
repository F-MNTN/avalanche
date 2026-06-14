{ pkgs, ... }:
{

  hardware.cpu.intel.updateMicrocode = true;

  hardware.graphics = {
    enable32Bit = true;
  };

  #programs.gamemode.enable = true; # this shit crashes the system every time

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    heroic # heroic launcher
    lutris # lutris launcher
    protonup-qt # GUI for installing custom Proton versions like GE_Proton
    azahar
    melonds
  ];
}
