{ ... }: {
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/mntn/.config/sops/age/keys.txt";
    secrets = {
      "wifi/eduroam/email" = { };
      "wifi/eduroam/password" = { };
    };
  };
}
