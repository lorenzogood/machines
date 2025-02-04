let
  mkHost = {
    type,
    hostPlatform,
    address ? null,
    pubkey ? null,
    remoteBuild ? false,
    large ? false,
  }:
    if type == "nixos"
    then
      assert address != null && pubkey != null;
      assert hostPlatform != null; {
        inherit hostPlatform address pubkey remoteBuild large type;
      }
    else {};
in {
  euclid = mkHost {
    type = "nixos";
    address = "192.168.50.32";
    hostPlatform = "x86_64-linux";
    pubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKo0M3BPWGIN02fUlqewx17qyMjANUmZTY13XINzXnQR root@euclid";
  };
}
