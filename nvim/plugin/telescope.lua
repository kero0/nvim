if vim.g.did_load_telescope_plugin then
  return
end
vim.g.did_load_telescope_plugin = true

local telescope = require('telescope')
local actions = require('telescope.actions')

local builtin = require('telescope.builtin')

local layout_config = {
  vertical = {
    width = function(_, max_columns)
      return math.floor(max_columns * 0.99)
    end,
    height = function(_, _, max_lines)
      return math.floor(max_lines * 0.99)
    end,
    prompt_position = 'bottom',
    preview_cutoff = 0,
  },
}

-- Fall back to find_files if not in a git repo
local project_files = function()
  local opts = {} -- define here if you want to define something
  local ok = pcall(builtin.git_files, opts)
  if not ok then
    builtin.find_files(opts)
  end
end

---@param picker function the telescope picker to use
local function grep_current_file_type(picker)
  local current_file_ext = vim.fn.expand('%:e')
  local additional_vimgrep_arguments = {}
  if current_file_ext ~= '' then
    additional_vimgrep_arguments = {
      '--type',
      current_file_ext,
    }
  end
  local conf = require('telescope.config').values
  picker {
    vimgrep_arguments = vim.tbl_flatten {
      conf.vimgrep_arguments,
      additional_vimgrep_arguments,
    },
  }
end

--- Grep the string under the cursor, filtering for the current file type
local function grep_string_current_file_type()
  grep_current_file_type(builtin.grep_string)
end

--- Live grep, filtering for the current file type
local function live_grep_current_file_type()
  grep_current_file_type(builtin.live_grep)
end

--- Like live_grep, but fuzzy (and slower)
local function fuzzy_grep(opts)
  opts = vim.tbl_extend('error', opts or {}, { search = '', prompt_title = 'Fuzzy grep' })
  builtin.grep_string(opts)
end

local function fuzzy_grep_current_file_type()
  grep_current_file_type(fuzzy_grep)
end

vim.keymap.set('n', '<leader>ff', function() builtin.find_files() end, { desc = '[f]ind [f]iles' })
vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = 'live grep' })

vim.keymap.set('n', '<leader>s', '<Nop>', { desc = '[s]earch' })
vim.keymap.set('n', '<leader>sf', fuzzy_grep, { desc = '[s]earch [f]uzzy' })
vim.keymap.set('n', '<leader>sS', fuzzy_grep_current_file_type, { desc = 'fuzzy grep filetype' })
vim.keymap.set('n', '<leader>ss', live_grep_current_file_type, { desc = 'live grep filetype' })
vim.keymap.set('n', '<leader>sp', project_files, { desc = '[s]earch [p]roject' })
vim.keymap.set('n', '<leader>sq', builtin.quickfix, { desc = '[s]earc [q]uickfix list' })
vim.keymap.set('n', '<leader>sc', builtin.command_history, { desc = '[s]earch [c]ommand history' })
vim.keymap.set('n', '<leader>sl', builtin.loclist, { desc = '[s]earch [l]oclist' })
vim.keymap.set('n', '<leader>sr', builtin.registers, { desc = '[s]earch [r]egisters' })
vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[s]earch [b]uffers [b]' })
vim.keymap.set('n', '<leader>sB', builtin.current_buffer_fuzzy_find, { desc = '[s]earch current [b]uffer fuzzy find' })
vim.keymap.set('n', '<leader>sd', builtin.lsp_document_symbols, { desc = '[s]earch lsp [d]ocument symbols' })
vim.keymap.set('n', '<leader>so', builtin.lsp_dynamic_workspace_symbols, { desc = '[s]earch lsp dynamic w[o]rkspace symbols' })

telescope.setup {
  defaults = {
    path_display = {
      'truncate',
    },
    layout_strategy = 'vertical',
    layout_config = layout_config,
    mappings = {
      i = {
        ['<C-q>'] = actions.send_to_qflist,
        ['<C-l>'] = actions.send_to_loclist,
        -- ['<esc>'] = actions.close,
        ['<C-s>'] = actions.cycle_previewers_next,
        ['<C-a>'] = actions.cycle_previewers_prev,
      },
      n = {
        q = actions.close,
      },
    },
    preview = {
      treesitter = true,
    },
    history = {
      path = vim.fn.stdpath('data') .. '/telescope_history.sqlite3',
      limit = 1000,
    },
    color_devicons = true,
    set_env = { ['COLORTERM'] = 'truecolor' },
    prompt_prefix = '   ',
    selection_caret = '  ',
    entry_prefix = '  ',
    initial_mode = 'insert',
    vimgrep_arguments = {
      'rg',
      '-L',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
  },
}

telescope.load_extension('fzy_native')
-- telescope.load_extension('smart_history')
