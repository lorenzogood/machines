{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };

    systems.url = "github:nix-systems/default";
  };

  outputs = inputs@{ self, ... }: inputs.flake-parts.lib.mkFlake { inherit inputs; } (toplevel@{ withSystem, ... }: {
    systems = [ "aarch64-darwin" "aarch64-linux" "x86_64-linux" ];

    imports = [
      ./definitions/nixos.nix
      ./definitions/deploy.nix
    ];

    perSystem = { config, self', inputs', pkgs, system, ... }: {
      _module.args.pkgs = import inputs.nixpkgs {
        localSystem = system;
        config = {
          allowUnfree = true;
          allowAliases = true;
        };
      };

      devShells.default = pkgs.mkShell {
        buildInputs = [ inputs'.deploy-rs.packages.default inputs'.agenix.packages.default ];
      };
    };

    flake = {
      hosts = import ./hosts.nix;
    };
  });
}
