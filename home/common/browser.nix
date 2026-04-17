{ config, pkgs, ...}: {
  programs.firefox = {
    enable = true;
    languagePacks = [
      "en_US"
      "de_AT"
      "zh-TW"
    ];
  };
}
