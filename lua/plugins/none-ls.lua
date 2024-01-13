return {
	"jay-babu/mason-null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"nvimtools/none-ls.nvim",
	},
	config = function()
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		local null_ls = require("null-ls")
		null_ls.setup({
			-- you can reuse a shared lspconfig on_attach callback here
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end,
			sources = {
				-- Basics
				null_ls.builtins.code_actions.gitsigns,
				null_ls.builtins.code_actions.refactoring,
				null_ls.builtins.completion.spell,

				-- lua
				null_ls.builtins.formatting.stylua,

				-- nix
				null_ls.builtins.formatting.nixfmt,

				-- python
				null_ls.builtins.diagnostics.pylint,
				null_ls.builtins.formatting.isort,
				null_ls.builtins.formatting.black,

			},
		})
		require("mason-null-ls").setup({
			ensure_installed = nil,
			automatic_installation = true,
		})
	end,
}
