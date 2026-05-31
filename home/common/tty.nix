{ pkgs, ... }: {
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
    initContent = ''
      if [[ -n "$NIX_SHELL_INDICATOR" ]]; then
        PROMPT="%F{cyan}[develop:$NIX_SHELL_INDICATOR]%f $PROMPT"
      fi
    '';
  };

  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
    enableZshIntegration = true;
    settings = {
      theme = "light:Rose Pine Dawn,dark:Rose Pine Moon";
      background-opacity = "0.8";
      cursor-style = "bar";
      mouse-hide-while-typing = true;
      font-family = "HackNerd Font Mono";
    };
  };
}
