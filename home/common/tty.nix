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

/*
  programs.alacritty = {
    enable = true;
    
    settings = {
      window = {
        padding = {
          x = 5;
          y = 5;
        };
        opacity = 0.95;
      };
      
      font = {
        normal = {
          family = "Hack Nerd Font Mono";
          style = "Regular";
        };
        bold = {
          style = "Bold";
        };
        italic = {
          style = "Italic";
        };
        size = 12;
      };
    };
  };
  */
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
