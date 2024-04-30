{ config, lib, pkgs, ... }:
let
  maintainers = import ../maintainers.nix;
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
      openssh.authorizedKeys.keys = maintainers.keys;
    };
  };
}
