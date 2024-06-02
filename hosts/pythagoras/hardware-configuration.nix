{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];
  boot.supportedFilesystems = ["btrfs"];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/d202af7b-6d12-4ecb-ae75-3cd8ff8ed163";
    fsType = "btrfs";
    options = ["subvol=root" "defaults" "noatime" "compress=lzo" "discard=async"];
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-uuid/d202af7b-6d12-4ecb-ae75-3cd8ff8ed163";
    fsType = "btrfs";
    options = ["subvol=persist" "defaults" "noatime" "compress=lzo" "discard=async"];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/d202af7b-6d12-4ecb-ae75-3cd8ff8ed163";
    fsType = "btrfs";
    options = ["subvol=nix" "defaults" "noatime" "compress=lzo" "discard=async"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D9A3-E98C";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/73628dfd-0d55-4eb2-81ad-a950ebd78b70";}
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp4s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
