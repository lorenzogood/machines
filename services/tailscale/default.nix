{ config, lib, pkgs, ... }:
let cfg = config.foehammer.tailscale;
in
{
  options.foehammer.tailscale = {
    enable = lib.mkEnableOption "Enables Tailscale";
  };

  config = lib.mkIf cfg.enable {
    age.secrets = {
      tskey.file = ./tskey.age;
    };

    services.tailscale = {
      enable = true;
      authKeyFile = config.age.secrets.tskey.path;
      openFirewall = true;
    };

    networking.firewall.trustedInterfaces = [ "tailscale0" ];
  };
}
