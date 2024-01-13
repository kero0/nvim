return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    opts = {
      log_level = vim.log.levels.OFF,
    },
  },

  -- function signature
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts) require 'lsp_signature'.setup(opts) end
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      { "L3MON4D3/LuaSnip" },
      { "onsails/lspkind.nvim" },
    },
    config = function()
      -- Here is where you configure the autocompletion settings.
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_cmp()

      -- And you can configure cmp even more, if you want to.
      local cmp = require("cmp")
      local cmp_action = lsp_zero.cmp_action()

      cmp.setup({
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = require("lspkind").cmp_format({
            mode = "symbol",       -- show only symbol annotations
            maxwidth = 50,         -- prevent the popup from showing more than provided characters
            ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp_action.luasnip_supertab(),
          ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason-lspconfig.nvim" },
      { "hrsh7th/nvim-cmp", }
    },
    config = function()
      -- This is where all the LSP shenanigans will live
      local lsp_zero = require("lsp-zero")
      local wk = require("which-key")
      lsp_zero.extend_lspconfig()

      --- if you want to know more about lsp-zero and mason.nvim
      --- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps({ buffer = bufnr })
        vim.api.nvim_exec([[
          augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.hover()
            autocmd CursorMoved <buffer> lua vim.diagnostic.open_float()
          augroup END
        ]],
          false
        )
        -- vim.api.nvim_create_autocmd( "CursorHold", {
        --     -- pattern = {"*"},
        --   buffer = bufnr,
        --     callback = function()
        --       if not require("cmp").visible() then
        --         local hover_fixed = function()
        --         vim.api.nvim_command("set eventignore=CursorHold")
        --         vim.api.nvim_command("autocmd CursorMoved ++once set eventignore=\" \" ")
        --         vim.lsp.buf.hover({focusable = false})
        --       end
        --       hover_fixed()
        --     end
        --   end
        --
        --   },
        --
        -- )
      end)

      require('lspconfig').nixd.setup({})

      require("mason-lspconfig").setup({
        automatic_installed = true,
        handlers = {
          lsp_zero.default_setup,
        },
      })

      wk.register({
        ["<leader>l"] = {
          name = "+LSP",
          D = { vim.lsp.buf.declaration, "Jump to the object declaration" },
          K = { vim.lsp.buf.hover, "Open the documentations of the object" },
          i = { vim.lsp.buf.implementation, "Jump to the implementation" },
          k = { vim.lsp.buf.signature_help, "Get the help documentations" },
          T = { vim.lsp.buf.type_definition, "Get the type definition" },
          r = { vim.lsp.buf.rename, "Rename the object under the cursor" },
          R = { vim.lsp.buf.references, "Jump to the reference of the object" },
          c = { vim.lsp.buf.code_action, "Open available code actions" },
          d = { vim.lsp.buf.definition, "Jump to object definition" },
        },
        ["<leader>w"] = {
          name = "+Workspace",
          a = { vim.lsp.buf.add_workspace_folder, "Add workspace folder" },
          r = { vim.lsp.buf.remove_workspace_folder, "Remove workspace folder" },
          l = { vim.inspect(vim.lsp.buf.list_workspace_folders), "List workspace folder" },
        },
      })
    end,
  },
}
