{ config, pkgs, lib, ... }:
let
  inherit (lib) mkIf mkEnableOption;

  cfg = config.foehammer.programs.caddy;
in
{
  options.foehammer.programs.caddy = {
    enable = mkEnableOption "Enable Caddy";
  };

  config = mkIf cfg.enable {
    services.caddy = {
      enable = true;
      email = "foehammer127@gmail.com";
    };

    networking.firewall.allowedTCPPorts = [ 80 443 ];
  };
}

