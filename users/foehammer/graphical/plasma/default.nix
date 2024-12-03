{pkgs, ...}: {
  imports = [
    ./generated.nix
  ];

  programs.plasma = {
    workspace.wallpaper = "${pkgs.foe-wallpapers}/mount-light.png";
    overrideConfig = true;
  };
}
