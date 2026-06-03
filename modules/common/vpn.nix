{ pkgs, config, ... }: {

  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "wg0-mullvad" "tailscale0"];
    allowedUDPPorts = [ config.services.tailscale.port ];
    checkReversePath = "loose";
  };

# --- Mullvad ---

  services.resolved = { #mullvad needs this to work; configures fallback dns
    enable = true;
    settings.Resolve = {
      Dnssec = "true";
      Domains = [ "~." ];
      FallbackDNS = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
      DNSoverTLS = "true";
    };
  };

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn; # mullvad only has cli ; change to mullvad-vpn to also include gui
  };

  systemd = {
    services."mullvad-daemon".environment.MULLVAD_SETTINGS_DIR = "/var/lib/mullvad-vpn"; # This is necessary if `system.etc.overlay.mutable` is set to false, because Mullvad expects the settings directory to be writable.
  };

# --- Tailscale ---
  services.tailscale.enable = true;
  networking.nftables.enable = true;
  systemd.services.tailscaled.serviceConfig.Environment = [
    "TS_DEBUG_FIREWALL_MODE=nftables"
  ];

# Optimization: Prevent systemd from waiting for network online
  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;
}
