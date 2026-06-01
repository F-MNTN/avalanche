{ config, pkgs, ... }: {
  # optimization
  boot.extraModprobeConfig = ''
    options iwlwifi bt_coex_active=0
    options iwlwifi swcrypto=1
    options iwlwifi power_save=0
    options iwlwifi uapsd_disable=1
    options iwlwifi d0i3_disable=1
    options iwlmvm power_scheme=1
  '';
}
