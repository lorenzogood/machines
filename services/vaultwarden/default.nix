{ config, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf mkOption;
  inherit (builtins) toString;

  cfg = config.foehammer.vaultwarden;
in
{
  options.foehammer.vaultwarden = {
    enable = mkEnableOption "Enable Vaultwarden Server";

    port = mkOption {
      type = lib.types.port;
      default = 8222;
      description = ''
        What external port to serve over.
      '';
    };
  };

  config = mkIf cfg.enable {
    age.secrets = {
      vaultwardenenv.file = ./env.age;
    };

    foehammer = {
      caddy.enable = true;
    };

    services.vaultwarden = {
      enable = true;

      config = {
        ROCKET_ADDRESS = "127.0.0.1";
        ROCKET_PORT = cfg.port;
        DOMAIN = "https://passwords.foehammer.me";
        ROCKET_LOG = "critical";
        SIGNUPS_ALLOWED = false;
        LOG_FILE = "/var/log/bitwarden.log";
      };

      environmentFile = config.age.secrets.vaultwardenenv.path;
    };

    services.caddy = {
      virtualHosts = {
        "passwords.foehammer.me" = {
          extraConfig = ''
            reverse_proxy :${toString cfg.port}
          '';
        };
      };
    };
  };
}
