{ ... }: {
  services."06cb-009a-fingerprint-sensor" = { # enable fingerprint sensor with python-validity backend 
    enable = true;
    # backend = "python-validity"; # enable for fprint-enroll and scanning a finger
    backend = "libfprint-tod"; # enale for regular validation
    calib-data-file = ./calib-data.bin; # import fingerprint data
  };  
}
