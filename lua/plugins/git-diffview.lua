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

  hooks = {
    diff_buf_read = function()
      vim.opt_local.wrap = false
      vim.opt_local.signcolumn = 'no'
    end,
  },
})
