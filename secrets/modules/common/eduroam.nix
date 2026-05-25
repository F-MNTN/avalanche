{ config, lib, ... }:
{
  sops.secrets."wifi/eduroam/email" = { };
  sops.secrets."wifi/eduroam/password" = { };

  sops.templates."eduroam.nmconnection" = {
    path = "/etc/NetworkManager/system-connections/eduroam.nmconnection";
    mode = "0600";
    content = ''
      [connection]
      id=eduroam
      type=wifi
      # Adding a stable UUID is good practice for NM
      uuid=13c28c26-6460-4beb-b36e-96a6a7eaec33

      [wifi]
      mode=infrastructure
      ssid=eduroam

      [wifi-security]
      key-mgmt=wpa-eap

      [802-1x]
      eap=peap;
      identity=${config.sops.placeholder."wifi/eduroam/email"}
      phase2-auth=mschapv2
      password=${config.sops.placeholder."wifi/eduroam/password"}

      [ipv4]
      method=auto

      [ipv6]
      addr-gen-mode=stable-privacy
      method=auto
    '';
  };

  networking.networkmanager.enable = true;
}
