{...}: {
  age.identityPaths = ["/persist/etc/ssh/ssh_host_ed25519_key"];

  environment.persistence."/persist" = {
    directories = [
      "/etc/NetworkManager/system-connections"
      "/root/.cache"
      "/var/lib/tailscale"
      "/var/lib/NetworkManager"
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/rfkill"
      "/var/lib/upower"
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
        ".local/share/direnv/allow"
        ".cache/nvim/luac"
        ".cache"
        ".local/share"
        ".local/state/nvim/shada"
        ".local/state/wireplumber"
        ".mozilla/firefox"
        ".config/chromium"
        ".config/inkscape"
        ".config/obsidian"
        ".config/obs-studio"
        ".config/pulse/cookie"
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
