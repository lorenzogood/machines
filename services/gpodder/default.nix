{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.foehammer.services.gpodder;

  inherit (lib) mkIf mkEnableOption mkOption;
in {
  options.foehammer.services.gpodder = {
    enable = mkEnableOption "Enable Gpodder Sync Service";

    port = mkOption {
      type = lib.types.port;
      default = 32837;
    };

    domain = mkOption {
      type = lib.types.str;
      example = "pods.example.com";
      description = "Domain name for the service";
    };
  };

  config = mkIf cfg.enable {
    age.secrets = {
      gpodderverifier = {
        file = ./verifier.age;
        owner = "gpodder2go";
      };
    };

    services.caddy = {
      virtualHosts = {
        "${cfg.domain}" = {
          extraConfig = ''
            reverse_proxy :${toString cfg.port}
          '';
        };
      };
    };

    users.users.gpodder2go = {
      createHome = true;
      description = "podcast syncing";
      isSystemUser = true;
      group = "dropship";
      home = "/var/lib/gpodder2go";
    };

    systemd.services.gpodder2go = {
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        User = "gpodder2go";
        Group = "dropship";
        Restart = "on-failure";
        WorkingDirectory = "/var/lib/gpodder2go";
        Type = "exec";
      };

      # Init currently fails on a no-op, will ask upstream to fix.
      script = let
        spath = config.age.secrets.gpodderverifier.path;
        pkg = "${pkgs.gpodder2go}/bin/gpodder2go";
      in ''
        [[ -f ${spath} ]] && export VERIFIER_SECRET_KEY=$(cat ${spath})
        set +e
        ${pkg} init
        set -e
        exec ${pkg} serve --addr "localhost:${toString cfg.port}"
      '';
    };
  };
}
