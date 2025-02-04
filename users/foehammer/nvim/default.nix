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
      rust-tools-nvim

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
      vimtex
    ];

  packages = let
    inherit (pkgs) nodePackages;
  in
    with pkgs; [
      #LSPs
      cuelsp
      elixir-ls
      gopls
      lua-language-server
      rust-analyzer
      tailwindcss-language-server
      nil
      nodePackages."@astrojs/language-server"
      nodePackages."typescript-language-server"
      nodePackages."diagnostic-languageserver"
      nodePackages."vscode-langservers-extracted"
      nodePackages."yaml-language-server"
      pyright
      zls

      #Formatters
      gofumpt
      alejandra
      rustfmt
      python3Packages.black

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
