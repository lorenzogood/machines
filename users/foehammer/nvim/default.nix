{
  config,
  lib,
  pkgs,
  ...
}: let
  plugins = let
    inherit (pkgs) vimPlugins;
  in with vimPlugins; [
	# Extra Stuff
  	nvim-colorizer-lua
	comment-nvim
	gitsigns-nvim
	lualine-nvim
	noice-nvim
	nvim-notify
	gruvbox-nvim
	nui-nvim
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
