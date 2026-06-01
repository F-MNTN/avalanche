{ pkgs, ... }:{
  fonts = {
    enableDefaultPackages = true; # language coverage
    packages = with pkgs; [
      # Emoji
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      # Compatibility
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
      # NERD
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
      nerd-fonts.hack
      nerd-fonts.jetbrains-mono
    ];
  };
}
