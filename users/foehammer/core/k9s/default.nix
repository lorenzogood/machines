{...}: {
  programs.k9s = {
    enable = true;

    settings = {
      skin = "gruvbox-foehammer";
    };

    skins = {
      gruvbox-foehammer = builtins.fromJSON (builtins.readFile ./gruvbox.json);
    };
  };
}
