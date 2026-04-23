{ config, pkgs, ... }:
{

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${config.programs.niri.package}/bin/niri-session";
        user = "mntn";
      };
    };
  };

  /**
  # Greeter + tuigreet
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.gdm}/bin/gdm --time --cmd niri-session";
        user = "greeter";
      };
    };
  };
**/

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

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-color-emoji
  ];
}
