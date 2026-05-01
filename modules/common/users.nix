{pkgs, ... }: {
  users.users.mntn = {
    isNormalUser = true;
    description = "mntn";
    extraGroups = [ "networkmanager" "wheel" "audio" "kvm"];
    shell = pkgs.zsh;
  }; 
  programs.zsh.enable = true;
}
