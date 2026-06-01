{ config, pkgs, ... }:
{
  # Disable gdm and gnome to fix a bug when fresh installing
  services.displayManager.gdm.enable = false;
  services.desktopManager.gnome.enable = false;
  # Greeter + tuigreet
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
        user = "greeter";
      };
    };
  };

  security.pam.services.greetd = {
    fprintAuth = true;
  };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  # System-level Niri
  programs.niri.enable = true;
  programs.dconf.enable = true;

  services.gnome.evolution-data-server.enable = true; # enable event support for calendar
  # Input
  services.xserver.xkb = {
    layout = "de_at";
    variant = "nodeadkeys";
  };
  services.libinput.enable = true;
  services.libinput.touchpad.clickMethod = "clickfinger";
}
