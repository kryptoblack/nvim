PARSERS = {
  'go',
  'lua',
  'python',
  'javascript',
  'typescript',
  'json',
  'yaml',
  'bash',
  'markdown',
  'dockerfile',
  'diff',
}

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    config = function()
      local ts = require('nvim-treesitter')

      ts.install(PARSERS):wait(300000)
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
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      select = {
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        -- You can choose the select mode (default is charwise 'v')
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * method: eg 'v' or 'o'
        -- and should return the mode ('v', 'V', or '<c-v>') or a table
        -- mapping query_strings to modes.
        selection_modes = {
          ['@parameter.outer'] = 'v', -- charwise
          ['@function.outer'] = 'V', -- linewise
          ['@class.outer'] = '<c-v>', -- blockwise
        },
      },

      move = {
        -- whether to set jumps in the jumplist
        set_jumps = true,
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding or succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * selection_mode: eg 'v'
      -- and should return true of false
      include_surrounding_whitespace = false,
    },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'BufRead',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      event = 'BufRead',
    },
    opts = {
      multiwindow = true,
    },
  },
}
