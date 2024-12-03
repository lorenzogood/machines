{pkgs, ...}: {
  imports = [
    ./plasma
    ./firefox.nix
    ./wezterm
    ./chromium.nix
    ./inkscape.nix
    ./obs.nix
  ];
  config = {
    home.packages = with pkgs; [
      zen-browser
    ];
  };
}
