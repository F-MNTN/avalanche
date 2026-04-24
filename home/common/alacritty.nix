{ config, pkgs, ... }: {
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
      
      # Add the rest of your custom keybinds, colors, etc. here
    };
  };
}
