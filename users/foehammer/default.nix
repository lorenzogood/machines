{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf optionals;

  keys = import ../../keys.nix;

  cfg = config.foehammer.user;
in {
  options.foehammer.user = {
    enable = mkEnableOption "Enable Foehammer User";
  };

  config = mkIf cfg.enable {
    age.secrets.foehammerPassword.file = ./password.age;

    users.groups.foehammer.gid = config.users.users.foehammer.uid;

    users.users.foehammer = {
      createHome = true;
      description = "Lorenzo Good";

      group = "foehammer";

      extraGroups = ["wheel" "dialout"];

      isNormalUser = true;

      uid = 8888;

      hashedPasswordFile = config.age.secrets.foehammerPassword.path;

      openssh.authorizedKeys.keys = with keys; [
        foe-leni-windows
        yubikey
      ];
    };

    home-manager.users.foehammer = {
      imports = [
        ./core
      ];

      home = {
        username = config.users.users.foehammer.name;
        stateVersion = "23.05";
      };
    };
  };
}
