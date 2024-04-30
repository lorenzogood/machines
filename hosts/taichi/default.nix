{ config, lib, pkgs, nixpkgs, ... }: {
  imports = [
    ../../hardware/digitalocean.nix
    ../../services/vaultwarden

    ../../core
  ];

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };

  foehammer = {
    vaultwarden.enable = true;
  };

  networking = {
    hostName = "taichi";
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
    };
  };


  swapDevices = [{
    device = "/var/lib/swap";
    size = 1024 * 1; # 1 GB Swap.
  }];

  environment.systemPackages = with pkgs; [ vim ];

  system.stateVersion = "24.05";
}

