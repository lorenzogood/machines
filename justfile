_default:
  @just --list

deploy TARGET="":
  @deploy .#{{TARGET}}
