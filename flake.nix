{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

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

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    plasma-manager = {
      url = "github:pjones/plasma-manager/plasma-5";

      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };

    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    systems.url = "github:nix-systems/default";
  };

  outputs = inputs @ {self, ...}:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} (toplevel @ {withSystem, ...}: {
      systems = ["aarch64-darwin" "aarch64-linux" "x86_64-linux"];

      imports = [
        ./definitions/nixos.nix
        ./definitions/deploy.nix
        ./definitions/overlays.nix
      ];

      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: {
        _module.args.pkgs = import inputs.nixpkgs {
          localSystem = system;
          config = {
            allowUnfree = true;
            allowAliases = true;
          };

          overlays = [
            self.overlays.default
          ];
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            deploy-rs.deploy-rs
            agenix
            alejandra
            just
            inputs'.plasma-manager.packages.rc2nix
          ];
        };

        formatter = inputs'.alejandra.packages.default;
      };

      flake = {
        hosts = import ./hosts.nix;
      };
    });
}
