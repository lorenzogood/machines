{ config, lib, pkgs, ... }:
let
  inherit (builtins) attrValues listToAttrs;
  maintainers =
    let
      file = import ../maintainers.nix;
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
      openssh.authorizedKeys.keys = maintainers;
    };
  };
}
