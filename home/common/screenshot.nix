{pkgs, ... }: {
  
  programs.satty = {
    enable = true;
    settings = {
      general = {
        early-exit = true; # exit after copy/save
        copy-command = "wl-copy --type image/png";
        corner-roundness = 12;
        initial-tool = "brush";
        output-filename = "/tmp/screenshot-%Y-%m-%d_%H:%M:%S.png";
      };
      color-palette = {
        palette = [ "#00ffff" "#a52a2a" "#dc143c" "#ff1493" "#ffd700" "#008000" ];
      };
    };
  };

  home.packages = with pkgs; [
    grim # create image
    slurp # select region of screen
    jq # tiny json interpreter for commands
    wl-clipboard # gives access to clipboard
  ];
}
