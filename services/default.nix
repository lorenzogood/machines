{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./tailscale
    ./vaultwarden
    ./restic
    ./gpodder
  ];
}
