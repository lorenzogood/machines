{
  config,
  lib,
  pkgs,
  hostname,
  ...
}: let
  inherit (builtins) attrValues listToAttrs;
  inherit (lib) mkEnableOption optionals;
  maintainerkeys = attrValues (import ../keys.nix);
in {
  imports = [
    ../services
    ./common
    ../users/foehammer
  ];

  config = {
    users.groups.dropship = {};

    foehammer = {
      tailscale.enable = true;
    };

    users.users.root = {
      openssh.authorizedKeys.keys = maintainerkeys;
    };

    users.mutableUsers = false;

    environment.systemPackages = with pkgs; [neovim git];

    networking = {
      hostName = hostname;
      firewall = {
        enable = true;
      };
    };

    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
      };
    };
  };
}
