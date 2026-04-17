{ config, pkgs, ... }: {
  users.users.mntn = {
    isNormalUser = true;
    description = "mntn";
    extraGroups = [ "networkmanager" "wheel" "audio"];
  };
}
