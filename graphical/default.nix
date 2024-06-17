{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.foehammer.graphical;
in {
  options.foehammer.graphical = {
    enable = mkEnableOption "Enable A Graphical User Environment";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
    };

    services.desktopManager.plasma6.enable = true;

    services.displayManager.sddm = {
      enable = true;
    };
  };
}
