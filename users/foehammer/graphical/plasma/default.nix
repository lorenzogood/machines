{pkgs, ...}: let
  wallpaper = "${pkgs.foe-wallpapers}/mountain-lake.png";
in {
  imports = [
    ./generated.nix
  ];

  programs.plasma = {
    # Set wallpapers.
    workspace.wallpaper = wallpaper;
  };
}
