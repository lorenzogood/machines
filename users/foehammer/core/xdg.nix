{...}: {
  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "$HOME/xdg/desktop";
      documents = "$HOME/xdg/documents";
      download = "$HOME/xdg/downloads";
      music = "$HOME/xdg/music";
      pictures = "$HOME/xdg/pictures";
      templates = "$HOME/xdg/templates";
      videos = "$HOME/xdg/videos";
      publicShare = "$HOME/xdg/public";
    };

    mimeApps = {
      enable = true;

      defaultApplications = {
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
      };
    };
  };
}
