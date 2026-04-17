{config, pkgs, ...}: {

  services.pulseaudio.enable = false;
  security.rtkit.enable = true; # rtkit is optional but recommended
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    extraConfig.pipewire."92-low-latency" = { # Tell pipewire to use bluez5
      "context.properties" = {
        "default.clock.rate" = 48000;
	"default.clock.quantum" = 1024;
      };
    };

    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    wireplumber = {
      enable = true;
      extraConfig.bluetoothEnhancements = {
        "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
          "bluez5.roles" = [ "a2dp_sink" "a2dp_source" "headset_head_unit" "headset_audio_gateway" ];
        };
      };
    };
  };
  environment.systemPackages = with pkgs; [
    pavucontrol
    pulseaudio
  ];
}
