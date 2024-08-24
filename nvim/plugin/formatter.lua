local null_ls = require("null-ls")

local sources = {
    null_ls.builtins.code_actions.gitrebase,
    null_ls.builtins.code_actions.gitsigns,

    null_ls.builtins.diagnostics.actionlint,
    null_ls.builtins.diagnostics.buf,
    null_ls.builtins.diagnostics.ktlint,
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.diagnostics.yamllint,

    null_ls.builtins.formatting.buf,
    null_ls.builtins.formatting.cbfmt,
    null_ls.builtins.formatting.cmake_format,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.yamlfmt,

    -- python
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.diagnostics.mypy,
    null_ls.builtins.diagnostics.pylint.with({
      diagnostics_postprocess = function(diagnostic)
        diagnostic.code = diagnostic.message_id
      end,
    }),
}

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      -- apply whatever logic you want (in this example, we'll only use null-ls)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
  sources = sources,
  -- on_attach = function(client, bufnr)
  --   if client.supports_method("textDocument/formatting") then
  --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  --     vim.api.nvim_create_autocmd("BufWritePre", {
  --       group = augroup,
  --       buffer = bufnr,
  --       callback = function()
  --         lsp_formatting(bufnr)
  --       end,
  --     })
  --   end
  -- end
})

