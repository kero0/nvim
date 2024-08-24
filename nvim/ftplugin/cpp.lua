local lsp_cmd = 'ccls'
if vim.fn.executable(lsp_cmd) ~= 1 then
  return
end

local root_files = {
  '.git',
  'compile_commands.json',
  'out',
  'build'
}

vim.lsp.start {
  name = lsp_cmd,
  cmd = { lsp_cmd },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = require('user.lsp').make_client_capabilities(),
  -- settings = {
  --   CPP = {
  --   }
  -- }
}
