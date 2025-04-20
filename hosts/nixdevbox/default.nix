{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../hardware/yubikey.nix
    ./hardware-configuration.nix
    ./state.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  foehammer = {
    user.enable = true;
  };

  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "24.11";

  networking.firewall.enable = false;
}
