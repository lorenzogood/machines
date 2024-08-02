let
  inherit (builtins) filter attrNames listToAttrs mapAttrs attrValues;

  maintainerkeys = attrValues (import ./keys.nix);

  hosts = let
    all = import ./hosts.nix;
    withpubkey = filter (a: all.${a} ? pubkey) (attrNames all);
  in
    listToAttrs (map (name: {
        inherit name;
        value = all.${name}.pubkey;
      })
      withpubkey);

  secrets = {
    "services/tailscale/tskey.age" = attrValues hosts;
    "services/vaultwarden/env.age" = attrValues hosts;
    "services/restic/env.age" = attrValues hosts;
    "services/restic/password.age" = attrValues hosts;
    "services/gpodder/verifier.age" = attrValues hosts;
    "users/foehammer/password.age" = attrValues hosts;
  };

  secrets' = mapAttrs (_: v: {publicKeys = maintainerkeys ++ v;}) secrets;
in
  secrets'
