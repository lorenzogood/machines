{ inputs, ... }:
let
  inherit (inputs.nixpkgs) lib;
  inherit (inputs) deploy-rs self nixpkgs;

  mkNode = hostname: nixosCfg:
    let
      inherit (self.hosts.${hostname}) address hostPlatform remoteBuild;
      inherit (deploy-rs.lib.${hostPlatform}) activate;
    in
    {
      inherit remoteBuild;
      hostname = address;
      profiles.system.path = activate.nixos nixosCfg;
      sshUser = "root";
      user = "root";
    };

in
{
  flake.deploy = {
    autoRollback = false;
    magicRollback = true;

    nodes = lib.mapAttrs mkNode (self.nixosConfigurations or { });
  };
}
