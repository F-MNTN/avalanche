{ pkgs, ... }: {

  services.ratbagd.enable = true; # Piper backend
  hardware.openrazer.enable = true; # razer backend
  users.users.mntn.extraGroups = [ "openrazer" ]; # 

  environment.systemPackages = with pkgs; [
    razergenie      # Clean, simple UI like Piper
    piper
    # polychromatic # Alternative UI focused heavily on macro layouts & RGB profiles
  ];
}
