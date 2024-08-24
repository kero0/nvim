pkgs: with pkgs.vimPlugins; [
  # basic
  catppuccin-nvim
  nvim-treesitter.withAllGrammars # treesitter

  # completions and snippets
  nvim-cmp
  luasnip # snippets
  cmp_luasnip # snippets autocompletion extension for nvim-cmp
  cmp-nvim-lsp # LSP as completion source
  cmp-nvim-lsp-signature-help
  cmp-buffer # current buffer as completion source
  cmp-path # file paths as completion source
  cmp-nvim-lua # neovim lua API as completion source
  cmp-cmdline # cmp command line suggestions
  cmp-cmdline-history # cmp command line history suggestions

  # lsp
  fidget-nvim
  lspkind-nvim # vscode-like LSP pictograms
  lsp_signature-nvim
  nvim-docs-view
  nvim-lsputils
  nvim-lspconfig
  virtual-types-nvim

  # none-ls
  none-ls-nvim

  # git integration plugins
  diffview-nvim
  neogit
  gitsigns-nvim
  vim-fugitive

  # telescope and extensions
  telescope-nvim
  telescope-fzy-native-nvim

  # UI
  lualine-nvim # Status line
  multicursors-nvim
  nvim-navic # Add LSP location to lualine
  nvim-treesitter-context # nvim-treesitter-context
  oil-nvim # directory editor
  rainbow-delimiters-nvim
  statuscol-nvim # Status column
  which-key-nvim

  # navigation/editing enhancement plugins
  eyeliner-nvim # Highlights unique characters for f/F and t/T motions
  nvim-surround
  nvim-treesitter-textobjects
  nvim-ts-autotag
  nvim-ts-context-commentstring
  ultimate-autopair-nvim
  vim-unimpaired # predefined ] and [ navigation keymaps

  # Useful utilities
  nvim-unception

  # libraries that other plugins depend on
  sqlite-lua
  plenary-nvim
  nvim-web-devicons
  vim-repeat
]
