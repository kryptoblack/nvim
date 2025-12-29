local diffview = require('diffview')

diffview.setup({
  enhanced_diff_hl = true,

  view = {
    merge_tool = {
      layout = 'diff3_mixed',
      disable_diagnostics = true,
    },
  },

  file_panel = {
    listing_style = 'tree',
    win_config = {
      width = 35,
    },
  },

  file_history_panel = {
    win_config = {
      height = 9,
    },
  },

  keymaps = {
    file_panel = {
      { 'n', '<leader>e', false, { desc = 'diffview_ignore', noremap = true } },
      { 'n', '<C-b>', false, { desc = 'diffview_ignore', noremap = true } },
    },
    file_history_panel = {
      { 'n', '<leader>e', false, { desc = 'diffview_ignore', noremap = true } },
      { 'n', '<C-b>', false, { desc = 'diffview_ignore', noremap = true } },
    },
  },

  hooks = {
    diff_buf_read = function()
      vim.opt_local.wrap = false
      vim.opt_local.signcolumn = 'no'
    end,
  },
})
