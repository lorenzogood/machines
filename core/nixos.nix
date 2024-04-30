{ config, lib, pkgs, ... }:
let
  maintainers = import ../maintainers.nix;
in
{
  imports = [
    ../services/tailscale
    ./caddy.nix
  ];

  config = {
    users.groups.dropship = { };

    foehammer = {
      tailscale.enable = true;
    };

    users.users.root = {
      openssh.authorizedKeys.keys = maintainers.keys;
    };
  };
}
