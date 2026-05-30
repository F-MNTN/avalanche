{ ...}: {
  programs.firefox = {
    enable = true;
    languagePacks = [
      "en_US"
      "de_AT"
      "zh-TW"
    ];
    profiles.default = {
      isDefault = true;
      id = 0;
      search.default = "ddg"; # set DuckDuckGo as default search engine
      extentions = [];
    };
  };
}
