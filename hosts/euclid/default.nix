{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./state.nix
    ../../hardware/yubikey.nix
    ../../hardware/sound.nix
    ../../hardware/printing.nix
    ../../hardware/virtual-camera.nix
    ../../hardware/zsa.nix
    ../../hardware/capslock/leni.nix
  ];

  foehammer = {
    user.enable = true;
    graphical.enable = true;
  };

  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "zfs";

  networking.networkmanager.enable = true;
  networking.hostId = "e4b69bf7";

  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkb.options in tty.
  };

  services.xserver.xkb.layout = "us";

  system.stateVersion = "24.05"; # Did you read the comment?
}
