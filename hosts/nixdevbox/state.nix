{config, ...}: {
  age.identityPaths = ["/persist/etc/ssh/ssh_host_ed25519_key"];

  environment.persistence."/persist" = {
    directories = [
      "/root/.cache"
      "/var/lib/tailscale"
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/rfkill"
      "/var/lib/docker"
    ];

    files = [
      "/etc/machine-id"
      "/etc/ssh/ssh_host_rsa_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/var/lib/systemd/random-seed"
    ];

    users.foehammer = {
      files = [];

      directories = [
        "src"
        "tmp"
        "doc"
        ".local/share/direnv/allow"
        ".cache/nvim/luac"
        ".cache"
        ".local/share"
        ".local/state/nvim/shada"
        ".config/kicad"
        {
          directory = ".gnupg";
          mode = "0700";
        }
        {
          directory = ".ssh";
          mode = "0700";
        }
      ];
    };
  };
}
