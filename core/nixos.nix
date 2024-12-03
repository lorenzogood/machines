{
  config,
  lib,
  pkgs,
  hostname,
  ...
}: let
  inherit (builtins) attrValues listToAttrs;
  inherit (lib) mkEnableOption optionals mkIf;
  maintainerkeys = attrValues (import ../keys.nix);
in {
  imports = [
    ../services
    ./common
    ../users/foehammer
  ];

  config = {
    users.groups.dropship = {};

    foehammer = {
      tailscale.enable = true;
    };

    users.users.root = {
      openssh.authorizedKeys.keys = maintainerkeys;
    };

    users.mutableUsers = false;

    environment.systemPackages = with pkgs; [neovim git];

    networking = {
      hostName = hostname;
      firewall = {
        enable = true;
      };

      nameservers = ["1.1.1.1" "8.8.8.8"];
      # If using dhcpcd:
      dhcpcd.extraConfig = mkIf config.networking.dhcpcd.enable "nohook resolv.conf";
      # If using NetworkManager:
      networkmanager.dns = mkIf config.networking.networkmanager.enable "none";
    };

    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
      };
    };
  };
}
