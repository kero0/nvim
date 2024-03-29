-- line numbers
vim.opt.relativenumber = true
vim.opt.number = true


vim.opt.shellslash = true
vim.opt.conceallevel = 2
vim.opt.concealcursor = 'nc'
-- vim.cmd('language en_US.utf8')

vim.cmd('set nocompatible')
vim.cmd('filetype plugin indent on')
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.hidden = true
vim.o.whichwrap = 'b,s,<,>,[,],h,l'
vim.o.pumheight = 10
vim.o.fileencoding = "utf-8"
vim.o.cmdheight = 2
vim.o.splitbelow = true
vim.o.termguicolors = true
vim.o.splitright = false
vim.o.conceallevel = 0
vim.o.showtabline = 2
vim.o.showmode = false
vim.o.backup = "auto"
vim.o.writebackup = true
vim.o.undofile = 1
vim.o.updatetime = 400
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.scrolloff = 3
vim.o.sidescrolloff = 5
vim.o.mouse = "a"
vim.o.expandtab = true
vim.o.cursorline = true

vim.wo.wrap = false
vim.wo.number = true
vim.wo.signcolumn = "yes"

local tab = 2

vim.o.tabstop = tab
vim.bo.tabstop = tab
vim.o.softtabstop = tab
vim.bo.softtabstop = tab
vim.o.shiftwidth = tab
vim.bo.shiftwidth = tab
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.expandtab = true
vim.bo.expandtab = true

vim.g.loaded_matchparen = 1
vim.g.loaded_matchit = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_remote_plugins = 1

vim.opt.dictionary:append("/usr/share/dict/words")
vim.opt.laststatus = 3
