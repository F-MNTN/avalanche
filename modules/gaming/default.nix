{ pkgs, ... }:{

  environment.systemPackages = with pkgs; [
    steam
    azahar
    melonDS
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  
  hardware.graphics = {
    enable32Bit = true; 
  };

}
