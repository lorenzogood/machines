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
  nixdevbox = mkHost {
    type = "nixos";
    address = "127.0.0.1";
    hostPlatform = "x86_64-linux";
    pubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILkLTFzpyGkbQEITzX339RMnJq3EYsSULd5Wayggjh4R root@nixdevbox";
  };
}
