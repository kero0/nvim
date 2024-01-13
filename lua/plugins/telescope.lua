return {
	'nvim-telescope/telescope.nvim',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local builtin = require('telescope.builtin')
		local wk = require("which-key")
		wk.register({
			["<leader>f"] = {
				name = "+file",
				f = { builtin.find_files, "Find File" },
				r = { builtin.oldfiles, "Open Recent File" },
				n = { "<cmd>enew<cr>", "New File" },
			},
			[ '<leader>/'] = { builtin.live_grep, "Search files" },
			[ '<leader><leader>' ] = { builtin.buffers, "Search buffers" },
			[ '<leader>h' ] = { builtin.help_tags, "Help tags" },
			[ '<M-x>' ] = { builtin.commands, "Exec command" },
			[ '<D-x>' ] = { builtin.commands, "Exec command" },
			[ '<leader>;' ] = { builtin.commands, "Exec command" },
			[ 'z=' ] = { builtin.commands, "Spell Suggest" },

		})
	end,
}
