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
    address = "138.197.24.110";
    hostPlatform = "x86_64-linux";
    pubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIODMXPfjzEZ6i6HAPP/Cs7j/6Am/OAO9ZDbpYTLSMfaP";
  };

  tao = mkHost {
    type = "nixos";
    address = "tao";
    hostPlatform = "x86_64-linux";
    pubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO5YQjcyIRCPEn0PTPjhrxYD/GL/SS2bywfy+Sg0qMaj root@tao";
  };

  pythagoras = mkHost {
    type = "nixos";
    address = "192.168.50.32";
    hostPlatform = "x86_64-linux";
    pubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB6dosylCON2r+VlEC7Pxi/TtnDJtftFKzy6uqTmMdlM";
  };
}
