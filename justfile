_default:
  @just --list

deploy TARGET="":
  @deploy .#{{TARGET}}

switch TARGET:
  @sudo nixos-rebuild switch --flake .#{{TARGET}}

switch-fast TARGET: 
  @sudo nixos-rebuild switch --fast .#{{TARGET}}

format: 
  @nix fmt
