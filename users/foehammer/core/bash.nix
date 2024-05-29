{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.bash = {
    enable = true;
  };

  home = {
    sessionVariables = {
      EDITOR = "nvim";
    };

    shellAliases = {
      vi = "nvim";
      vim = "nvim";
    };
  };
}
