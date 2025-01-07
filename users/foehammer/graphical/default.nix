{pkgs, ...}: {
  imports = [
    ./plasma
    ./wezterm
  ];

  programs = {
    obs-studio = {
      enable = true;
    };

    firefox.enable = true;

    chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
      extensions = [
        "cjpalhdlnbpafiamejdnhcphjbkeiagm"
        "nngceckbapebfimnlniiiahkandclblb"
      ];
    };
  };

  home.packages = with pkgs; [
    kicad
    inkscape
    signal-desktop
  ];
}
