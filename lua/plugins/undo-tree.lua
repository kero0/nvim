return {
  "debugloop/telescope-undo.nvim",
  dependencies = { -- note how they're inverted to above example
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
  },
  keys = {
    { -- lazy style key map
      "<leader>u",
      "<cmd>Telescope undo<cr>",
      desc = "undo history",
    },
  },
  opts = {
    extensions = {
      undo = {
        mappings = {
          i = {
            ["<cr>"] = function(bufnr) require("telescope-undo.actions").yank_additions(bufnr) end,
            ["<S-cr>"] = function(bufnr) require("telescope-undo.actions").yank_deletions(bufnr) end,
            ["<C-cr>"] = function(bufnr) require("telescope-undo.actions").restore(bufnr) end,
            -- alternative defaults, for users whose terminals do questionable things with modified <cr>
            ["<C-y>"] = function(bufnr) require("telescope-undo.actions").yank_deletions(bufnr) end,
            ["<C-r>"] = function(bufnr) require("telescope-undo.actions").restore(bufnr) end,
          },
          n = {
            ["y"] = function(bufnr) require("telescope-undo.actions").yank_additions(bufnr) end,
            ["Y"] = function(bufnr) require("telescope-undo.actions").yank_deletions(bufnr) end,
            ["u"] = function(bufnr) require("telescope-undo.actions").restore(bufnr) end,
          },
        },
        use_delta = true,
        use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
        side_by_side = false,
        diff_context_lines = vim.o.scrolloff,
        entry_format = "state #$ID, $STAT, $TIME",
        time_format = "",
        saved_only = false,
        layout_strategy = "vertical",
        layout_config = {
          preview_height = 0.8,
        },
      },
    },
  },
  config = function(_, opts)
    -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
    -- configs for us. We won't use data, as everything is in it's own namespace (telescope
    -- defaults, as well as each extension).
    require("telescope").setup(opts)
    require("telescope").load_extension("undo")
  end,
}
