{
  config,
  lib,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [zellij];

    file.".config/zellij/config.kdl".source = ./config.kdl;
  };
}
