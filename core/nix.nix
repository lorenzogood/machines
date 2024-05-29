{
  config,
  lib,
  pkgs,
  ...
}: {
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    settings = {
      experimental-features = [
        "auto-allocate-uids"
        "flakes"
        "nix-command"
      ];

      trusted-users = ["root" "@wheel"];
    };
  };
}
