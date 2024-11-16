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
  taichi = mkHost {
    type = "nixos";
    address = "taichi";
    hostPlatform = "x86_64-linux";
    pubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIODMXPfjzEZ6i6HAPP/Cs7j/6Am/OAO9ZDbpYTLSMfaP";
  };

  pythagoras = mkHost {
    type = "nixos";
    address = "192.168.50.32";
    hostPlatform = "x86_64-linux";
    pubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB6dosylCON2r+VlEC7Pxi/TtnDJtftFKzy6uqTmMdlM";
  };

  euclid = mkHost {
    type = "nixos";
    address = "192.168.50.32";
    hostPlatform = "x86_64-linux";
    pubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOZWR6SpviukCMyUJD7qZR9AosdUWgay/5g9fO06++l3 root@euclid";
  };
}
