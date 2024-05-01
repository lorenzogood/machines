{ config, lib, pkgs, hostname, ... }:
let
  inherit (builtins) attrValues listToAttrs;
  maintainerkeys =
    let
      file = import ../keys.nix;
    in
    attrValues file;

in
{
  imports = [
    ./caddy.nix
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
