{pkgs, ...}: {
  imports = [
    ./generated.nix
  ];

  programs.plasma = {
    # Set wallpapers.
    workspace.wallpaper = "${pkgs.foe-wallpapers}/mountain-lake.png";
  };
}
