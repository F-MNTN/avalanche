{ config, pkgs, ... }: {
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber = {
      enable = true;
      extraConfig.bluetoothEnhancements = {
        "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
          "bluez5.roles" = [ "a2dp_sink" "a2dp_source" "headset_head_unit" "headset_audio_gateway" ];
          # Disable LDAC — its decoder fails to init, prefer AAC instead
          "bluez5.codecs" = [ "aac" "sbc_xq" "sbc" ];
        };
      };
    };
  };
  environment.systemPackages = with pkgs; [
    pavucontrol
    pulseaudio
  ];
}
