{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./nix.nix
    ./nixos.nix
    ../graphical
  ];
}
