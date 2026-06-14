{ config, lib, pkgs, ... }:
with lib;
{
  options.avalanche.bluetooth = {
    enable = mkEnableOption "bluetooth support";
    intelCoexFix = mkOption {
      type = types.bool;
      default = false;
      description = "Apply Intel WiFi/BT coexistence fixes (T480/Intel WiFi only)";
    };
  };

  config = mkIf config.avalanche.bluetooth.enable {
    hardware = {
      bluetooth = {
        enable = true;
        powerOnBoot = true;
        settings = {
          General = {
            ControllerMode = "dual";
            Experimental = true;
            FastConnectable = true;
          };
          Policy.AutoEnable = true;
        };
      };
    };
    
    services.dbus.enable = true;
    services.blueman.enable = true;
  };
}
