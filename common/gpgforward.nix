{
  config,
  lib,
  ...
}: let
  cfg = config.foehammer.gpg-forwarding;

  inherit (lib) mkEnableOption mkIf;
in {
  options.foehammer.gpg-forwarding = {
    enable = mkEnableOption "Enable This Host To Recieve GPG Keys Over SSH";
  };

  config = mkIf cfg.enable {
    services.openssh.settings = {
      StreamLocalBindUnlink = true;
    };
  };
}
