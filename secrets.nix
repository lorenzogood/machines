let
  inherit (builtins) filter attrNames listToAttrs mapAttrs attrValues;


  maintainers =
    let
      file = import ./maintainers.nix;
      names = attrNames file;
    in
    listToAttrs (map (name: { inherit name; value = file.${name}; }) names);

  hosts =
    let
      all = import ./hosts.nix;
      withpubkey = filter (a: all.${a} ? pubkey) (attrNames all);
    in
    listToAttrs (map (name: { inherit name; value = all.${name}.pubkey; }) withpubkey);

  secrets = with hosts; {
    "services/tailscale/tskey.age" = attrValues hosts;
    "services/vaultwarden/env.age" = [ taichi ];
  };

  secrets' = mapAttrs (_: v: { publicKeys = attrValues maintainers ++ v; }) secrets;
in
secrets'
