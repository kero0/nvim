vim.g.mapleader = ' '
vim.g.maplocalleader = ' m'



map = function(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

