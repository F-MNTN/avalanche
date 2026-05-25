{ config, pkgs, ... }: { # fix localsend discorvery by adding firewall rule
  networking.firewall.allowedTCPPorts = [ 53317 ];  
  networking.firewall.allowedUDPPorts = [ 53317 ];
}
