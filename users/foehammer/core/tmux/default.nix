{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;

    baseIndex = 1;
    clock24 = true;
    keyMode = "vi";
    newSession = true;

    resizeAmount = 10;
    shortcut = "b";
    terminal = "screen-256color";

    plugins = with pkgs.tmuxPlugins; [
      yank
    ];

    extraConfig = builtins.readFile ./tmux.conf;

    customPaneNavigationAndResize = true;
  };
}
