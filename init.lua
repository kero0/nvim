require("core.keybindings")
require("core.options")

require("core.lazy-setup").setup({

	{
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			init = function()
				vim.o.timeout = true
				vim.o.timeoutlen = 300
			end,
			opts = {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			},
		},
		"folke/neodev.nvim",
		{
			-- Add indentation guides even on blank lines
			"lukas-reineke/indent-blankline.nvim",
			-- See `:help ibl`
			main = "ibl",
			opts = {},
		},
	},
	{ "numToStr/Comment.nvim", opts = {} },

	{ import = "plugins" },
})
