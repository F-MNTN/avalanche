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
      firmware = with pkgs; [ rtl8761b-firmware ];
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

    # Realtek BT dongle 2b89:8761 — disable autosuspend
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="2b89", ATTR{idProduct}=="8761", \
        ATTR{power/autosuspend}="-1"
    '';

    boot.extraModprobeConfig = lib.mkMerge [
      (lib.mkIf config.avalanche.bluetooth.intelCoexFix ''
        options iwlwifi bt_coex_active=0
        options iwlwifi swcrypto=1
        options iwlwifi power_save=0
        options iwlwifi uapsd_disable=1
        options iwlwifi d0i3_disable=1
        options iwlmvm power_scheme=1
      '')
      ''
        options btusb enable_autosuspend=0
      ''
    ];
  };
}
