{ withSystem, inputs, ... }:
let
  inherit (inputs.nixpkgs) lib;
  inherit (inputs) agenix;

  mkSystem = hostname: { address, hostPlatform, type, ... }:
    withSystem hostPlatform ({ pkgs, ... }:
      lib.nixosSystem {
        modules = [
          (../hosts + "/${hostname}")
          {
            nix.registry = {
              nixpkgs.flake = inputs.nixpkgs;
              p.flake = inputs.nixpkgs;
            };
            nixpkgs.pkgs = pkgs;
          }
          agenix.nixosModules.default
          ../core
        ];
        specialArgs = {
          inherit hostname;
        };
      });

in
{
  flake = {
    nixosConfigurations = lib.mapAttrs mkSystem (lib.filterAttrs (_: host: host.type == "nixos") inputs.self.hosts);
  };
}
