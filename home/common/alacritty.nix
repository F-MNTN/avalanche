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
}
