{ pkgs, ... }: {

  programs.coolercontrol.enable = true;

  environment.systemPackages = with pkgs; [

    liquidctl # tool and drivers for liquid coolers etc.
    lm_sensors # userspace support for hardware monitoring drivers

    geekbench
  ];
}
