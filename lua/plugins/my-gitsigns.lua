local function on_attach()
  local gitsigns = require('gitsigns')
  gitsigns.setup({
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '-' },
      topdelete = { text = '-' },
      changedelete = { text = '~' },
    },

    signcolumn = true,
    numhl = false,
    linehl = false,

    current_line_blame = false,
    update_debounce = 100,

    preview_config = {
      border = 'single',
      style = 'minimal',
    },
  })
end

return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = on_attach,
}
