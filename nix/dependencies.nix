pkgs: with pkgs; [
  ripgrep
  fd

  # language servers
  lua-language-server
  nixd
  (python312.withPackages(p: with p;[ python-lsp-server ]))

  # none-ls
  ## code actions
  gitsign
  ## diagnostics
  actionlint
  buf
  ktlint
  markdownlint-cli
  yamllint
  ## formatting
  cbfmt
  cmake-format
  shfmt
  stylua
  yamlfmt
  ## python
  black
  isort
  mypy
  pylint
]
