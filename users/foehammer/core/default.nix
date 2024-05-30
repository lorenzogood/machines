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
    ./tmux
  ];
  home = {
    packages = with pkgs; [
      wget
      curl
    ];
  };
}
