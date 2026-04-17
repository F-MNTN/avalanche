{
  config,
  ...
}:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "F-MNTN";
      user.email = config.sops.secrets."github_email".path;
    };
  };
}
