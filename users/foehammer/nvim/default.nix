{pkgs, ...}: let
  plugins = let
    inherit (pkgs) vimPlugins;
  in
    with vimPlugins; [
      # Languages
      nvim-lspconfig
      nvim-treesitter.withAllGrammars

      # Telescope Stuff
      telescope-nvim
      plenary-nvim

      # Extra Stuff
      nvim-colorizer-lua
      comment-nvim
      gitsigns-nvim
      lualine-nvim
      noice-nvim
      nvim-notify
      gruvbox-nvim
      nui-nvim
      nvim-treesitter-context
      nvim-web-devicons
    ];

  packages = with pkgs; [
    #LSPs
    gopls
    lua-language-server
    nil

    #Formatters
    gofumpt
    alejandra

    # Telescope Stuff
    ripgrep
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
  home.packages = with pkgs; [ripgrep];

  programs.neovim = {
    inherit extraConfig;
    plugins = plugins ++ [vimPlugin];
    extraPackages = packages;

    enable = true;
    defaultEditor = true;

    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };
}
