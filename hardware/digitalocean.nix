{ config, lib, pkgs, modulesPath, ... }: {
  imports = [
    (modulesPath + "/virtualisation/digital-ocean-config.nix")
  ];

  config = {
    virtualisation.digitalOcean.rebuildFromUserData = false;
  };
}
