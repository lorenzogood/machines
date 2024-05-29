{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./git.nix
    ./bash.nix
    ./gpg
    ./direnv.nix
  ];
  home = {
    packages = with pkgs; [
      wget
      curl
    ];
  };
}
