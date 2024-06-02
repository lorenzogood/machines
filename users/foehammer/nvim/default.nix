{pkgs, ...}: let
  plugins = let
    inherit (pkgs) vimPlugins;
  in
    with vimPlugins; [
      # Languages
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      nvim-cmp
      luasnip
      cmp_luasnip
      cmp-nvim-lsp
      cmp-buffer

      # Telescope Stuff
      telescope-nvim
      plenary-nvim

      # Extra Stuff
      gitsigns-nvim
      lualine-nvim
      noice-nvim
      nvim-notify
      gruvbox-nvim
      nui-nvim
      nvim-treesitter-context
      nvim-web-devicons
    ];

  packages = let
    inherit (pkgs) nodePackages;
  in
    with pkgs; [
      #LSPs
      gopls
      lua-language-server
      nil
      nodePackages."yaml-language-server"
      nodePackages."vscode-langservers-extracted"

      #Formatters
      gofumpt
      alejandra

      # Telescope Stuff
      ripgrep
      fd
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
  home.packages = with pkgs; [ripgrep fd];

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
