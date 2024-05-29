{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./git.nix
    ./bash.nix
    ./zellij
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
