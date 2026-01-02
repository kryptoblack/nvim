return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    event = { 'BufReadPre', 'BufNewFile' },
    build = ':TSUpdate',
    config = function()
      local ts = require('nvim-treesitter')

      -- These are Async calls
      ts.install(require('config.constants').parsers):wait(300000)
      ts.update()

      ts.setup({
        sync_install = false,
        auto_install = false,
        install_dir = vim.fn.stdpath('data') .. '/site',
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = { 'BufRead', 'BufNewFile' },
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      select = {
        lookahead = true,
        selection_modes = {
          ['@parameter.outer'] = 'v',
          ['@function.outer'] = 'V',
          ['@class.outer'] = '<c-v>',
        },
      },

      move = {
        set_jumps = true,
      },
      include_surrounding_whitespace = false,
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = { 'BufRead', 'BufNewFile' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      multiwindow = true,
    },
  },
}
