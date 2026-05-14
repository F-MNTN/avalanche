{ config, pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      updateMe = "sudo nixos-rebuild switch --flake .#$HOSTNAME";
    };

    history = {
      size = 10000;
      path = "$HOME/.zsh_history";
    };
    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
    ];
  };

  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
    enableZshIntegration = true;
    settings = {
      theme = "light:Rose Pine Dawn,dark:Rose Pine";
      background-opacity = "0.8";
      cursor-style = "bar";
      mouse-hide-while-typing = true;
      font-family = "HackNerd Font Mono";
    };
  };
}
