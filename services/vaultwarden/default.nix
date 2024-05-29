{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkOption;
  inherit (builtins) toString;

  cfg = config.foehammer.services.vaultwarden;
in {
  options.foehammer.services.vaultwarden = {
    enable = mkEnableOption "Enable Vaultwarden Server";

    port = mkOption {
      type = lib.types.port;
      default = 8222;
      description = ''
        What external port to serve over.
      '';
    };

    signups = mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    age.secrets = {
      vaultwardenenv.file = ./env.age;
    };

    foehammer = {
      programs.caddy.enable = true;
      restic = {
        paths = ["/var/lib/bitwarden_rs"];
      };
    };

    services.vaultwarden = {
      enable = true;

      config = {
        ROCKET_ADDRESS = "127.0.0.1";
        ROCKET_PORT = cfg.port;
        DOMAIN = "https://passwords.foehammer.me";
        ROCKET_LOG = "critical";
        SIGNUPS_ALLOWED = cfg.signups;
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
