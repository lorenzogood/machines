{
  config,
  lib,
  pkgs,
  ...
}: {
  services.gpg-agent = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    enableScDaemon = true;
    defaultCacheTtl = 34560000;
    maxCacheTtl = 34560000;
    pinentryPackage = pkgs.pinentry.tty;
  };

  programs.gpg = {
    enable = true;

    scdaemonSettings = {
      disable-ccid = true;
    };

    # Basically Ripped From Yubikey-Guide
    settings = {
      personal-cipher-preferences = "AES256 AES192 AES";

      personal-digest-preferences = "SHA512 SHA384 SHA256";

      personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";

      default-preference-list = "SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed";

      cert-digest-algo = "SHA512";

      s2k-digest-algo = "SHA512";

      s2k-cipher-algo = "AES256";

      charset = "utf-8";

      no-comments = "";

      no-emit-version = "";

      no-greeting = "";

      keyid-format = "0xlong";

      list-options = "show-uid-validity";

      with-fingerprint = "";

      require-cross-certification = "";

      no-symkey-cache = "";

      armor = "";

      use-agent = "";

      throw-keyids = "";

      default-key = "A972C2063F4F2554";

      trusted-key = "A972C2063F4F2554";
    };

    publicKeys = [
      # Personal Yubikey.
      {
        source = ./pubkey.txt;
        trust = "ultimate";
      }
    ];

    mutableTrust = false;
    mutableKeys = false;
  };
}
