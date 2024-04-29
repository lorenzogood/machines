{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, ... }: inputs.flake-parts.lib.mkFlake { inherit inputs; } { };
}
