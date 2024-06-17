{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "foehammer127";
    userEmail = "foehammer@disroot.org";

    signing = {
      key = "A972C2063F4F2554";
      signByDefault = true;
    };

    extraConfig = {
      init = {defaultBranch = "main";};
      pull = {rebase = true;};
      rebase = {verify = false;};
    };

    # Git aliases to use
    aliases = {
      c = "commit";
      cc = "commit";
      co = "checkout";
      cb = "checkout -b";
      aa = "add -A";
      a = "add";
      ca = "commit --amend";
      l = "log";
      lo = "log --oneline";
    };
  };
}
