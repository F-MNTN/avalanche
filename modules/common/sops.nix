{ ... }: {
  # --- SOPS ---
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/mntn/.config/sops/age/keys.txt";
    secrets = {
      "github/email" = { };
      "wifi/eduroam/email" = { };
      "wifi/eduroam/password" = { };
    };
  };

}
