{inputs, ...}: let
  inherit (inputs.nixpkgs) lib;

  inherit (inputs) agenix alejandra deploy-rs;

  importLocalOverlay = file:
    lib.composeExtensions
    (_: _: {__inputs = inputs;})
    (import (../overlays + "/${file}"));

  localOverlays =
    lib.mapAttrs' (
      f: _:
        lib.nameValuePair
        (lib.removeSuffix ".nix" f)
        (importLocalOverlay f)
    )
    (builtins.readDir ../overlays);
in {
  flake.overlays =
    localOverlays
    // {
      default = lib.composeManyExtensions ([
          agenix.overlays.default
          alejandra.overlays.default
          deploy-rs.overlays.default
        ]
        ++ (lib.attrValues localOverlays));
    };
}
