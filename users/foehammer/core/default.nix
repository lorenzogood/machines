{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkOption types;
in {
  imports = [
    ./git.nix
    ./bash.nix
    ./gpg
    ./direnv.nix
    ./tmux
    ./xdg.nix
  ];

  options.home.uid = mkOption {
    type = with types; nullOr int;
    default = null;
    description = ''
      The account UID. If the UID is null, a free UID is picked on
      activation.
    '';
  };

  config = {
    home = {
      packages = with pkgs; [
        wget
        curl
        htop
      ];
    };
  };
}
