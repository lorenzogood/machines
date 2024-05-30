{
  config,
  lib,
  pkgs,
  ...
}: let
  plugins = let
    inherit (pkgs) vimPlugins;
  in [
  ];

  vimPlugin = let
    inherit (pkgs.vimUtils) buildVimPlugin;
  in
    buildVimPlugin {
      name = "FoehammerVim";
      src = ./config;
    };

  extraConfig = ''
    lua << EOF
    	require 'FoehammerVim'.init()
    EOF
  '';
in {
  programs.neovim = {
    inherit extraConfig;
    plugins = plugins ++ [vimPlugin];

    enable = true;
    defaultEditor = true;

    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };
}
