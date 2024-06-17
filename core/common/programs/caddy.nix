{
  config,
  pkgs,
  lib,
  ...
}: {
  config = {
    services.caddy = {
      email = "foehammer127@gmail.com";
    };

    networking.firewall.allowedTCPPorts = [80 443];
  };
}
