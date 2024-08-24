if vim.g.did_load_gitsigns_plugin then
  return
end
vim.g.did_load_gitsigns_plugin = true

vim.schedule(function()
  require('gitsigns').setup {
    current_line_blame = false,
    current_line_blame_opts = {
      ignore_whitespace = true,
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']g', function()
        if vim.wo.diff then
          return ']g'
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return '<Ignore>'
      end, { expr = true, desc = '[g]it next hunk' })

      map('n', '[g', function()
        if vim.wo.diff then
          return '[g'
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return '<Ignore>'
      end, { expr = true, desc = '[g]it previous hunk' })

      -- Actions
      require('which-key').add({

      {
         mode = { 'n', 'v' },
         group = "[g]it",
      {'<leader>g', '', { desc = '[g]it' }},
      {'<leader>gs', function() vim.cmd.Gitsigns('stage_hunk') end, { desc = '[g]it [s]tage hunk' }},
      {'<leader>gr', function() vim.cmd.Gitsigns('reset_hunk') end, { desc = '[g]it [r]eset hunk' }},
      },
      {
         mode = 'n',
      {'<leader>gS', gs.stage_buffer, { desc = '[g]it [s]tage buffer' }},
      {'<leader>gu', gs.undo_stage_hunk, { desc = '[g]it [u]ndo hunk stage' }},
      {'<leader>gR', gs.reset_buffer, { desc = '[g]it [R]eset buffer' }},
      {'<leader>gp', gs.preview_hunk, { desc = '[g]it [p]review hunk' }},
      {'<leader>gb', function() gs.blame_line { full = true } end, { desc = 'git [b]lame line (full)' }},
      {'<leader>gB', gs.toggle_current_line_blame, { desc = '[g]it toggle current line [b]lame' }},
      {'<leader>gd', gs.diffthis, { desc = 'git [h] [d]iff this' }},
      {'<leader>gD', function() gs.diffthis('~1') end, { desc = 'git [D]iff ~1' }},
      {'<leader>td', gs.toggle_deleted, { desc = 'git [t]oggle [d]eleted' }},
      },
      {
         mode={ 'o', 'x' },
      {'<C-U>Gitsigns select_hunk<CR>', { desc = 'git stage buffer' }}
      },
                              })
      -- Text object
    end,
  }
end)
