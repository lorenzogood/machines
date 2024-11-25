{pkgs, ...}: {
  imports = [
    ./generated.nix
  ];

  programs.plasma = {
    workspace.wallpaper = "${pkgs.foe-wallpapers}/mountain-lake.png";
    overrideConfig = true;
  };
}
