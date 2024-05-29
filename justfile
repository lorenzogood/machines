_default:
  @just --list

deploy TARGET="":
  @deploy .#{{TARGET}}

switch TARGET:
  @sudo nixos-rebuild switch --flake .#{{TARGET}}

format: 
  @nix fmt
