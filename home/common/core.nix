{
  config,
  pkgs,
  inputs,
  ...
}:
{
  home.username = "mntn";
  home.homeDirectory = "/home/mntn";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  imports = [
    inputs.sops-nix.homeManagerModules.sops
    ./noctalia.nix
    ./alacritty.nix
    ./git.nix
    ./nvf-configuration.nix
    ./obsidian.nix
    ./browser.nix
    ./email.nix
  ];

  # --- SOPS Configuration ---
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    secrets = {
      "github_email" = { };

      "eduroam_email" = {
        key = "wifi/eduroam/email";
      };
      "eduroam_password" = {
        key = "wifi/eduroam/password";
      };
    };
  };

  home.packages = with pkgs; [
    # Terminal / TUI ----------------------------
    nautilus # file manager
    tealdeer # tldr
    btop # monitor
    fastfetch
    ripgrep-all # ripgrep but also searhes pdfs, etc...
    unrar
    unzip
    curl
    tree
    xwayland-satellite # x11 wayland translator

    # Standalone --------------------------------
    sioyek # pdf reader
    localsend
    pavucontrol # audio i/o control
    easyeffects # audio tools and effects (may replace pavucontrol)
  ];

  # one-line Programs -------------------------

  # Wayland environment variables (good to have globally for GUI hosts)
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
  };
}
