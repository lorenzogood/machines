let
  mkHost = { type, hostPlatform, address ? null, pubkey ? null, remoteBuild ? false, large ? false }:
    if type == "nixos" then
      assert address != null && pubkey != null;
      assert hostPlatform != null;
      {
        inherit hostPlatform address pubkey remoteBuild large type;
      } else { };
in
{
  taichi = mkHost {
    type = "nixos";
    address = "taichi";
    hostPlatform = "x86_64-linux";
    pubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIODMXPfjzEZ6i6HAPP/Cs7j/6Am/OAO9ZDbpYTLSMfaP";
  };
}
