{ config, lib, pkgs, hostname, ... }:
let
  inherit (lib) mkEnableOption mkIf mkOption types;

  cfg = config.foehammer.restic;
in
{
  options.foehammer.restic = {
    enable = mkEnableOption "Restic Backups";

    paths = mkOption {
      type = types.nullOr (types.listOf types.str);
      default = [ ];
    };

    exclude = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
  };

  config = mkIf cfg.enable {
    age.secrets = {
      resticenv.file = ./env.age;
      resticpassword.file = ./password.age;
    };


    services.restic.backups = {
      remote = {
        paths = cfg.paths;
        exclude = cfg.exclude;
        repository = "s3:s3.us-east-005.backblazeb2.com/foehammer-nixos-backups/${hostname}";
        environmentFile = config.age.secrets.resticenv.path;
        passwordFile = config.age.secrets.resticpassword.path;

        pruneOpts = [
          "--keep-daily 7"
          "--keep-weekly 4"
        ];
      };
    };
  };
}
