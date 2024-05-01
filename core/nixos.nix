{ config, lib, pkgs, ... }:
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
  };
}
