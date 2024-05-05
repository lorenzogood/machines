{ config, lib, pkgs, hostname, ... }:
let
  inherit (builtins) attrValues listToAttrs;
  maintainerkeys = attrValues (import ../keys.nix);

in
{
  imports = [
    ./programs/caddy.nix
    ../services
  ];

  config = {
    users.groups.dropship = { };

    foehammer = {
      tailscale.enable = true;
    };

    users.users.root = {
      openssh.authorizedKeys.keys = maintainerkeys;
    };

    users.mutableUsers = false;

    environment.systemPackages = with pkgs; [ vim ];

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
