return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('neo-tree').setup({
        close_if_last_window = true,
        clipboard = { sync = 'global' },
        use_popups_for_input = false,
        window = {
          width = 30,
          mappings = {
            ['<space>'] = 'none',
          },
          auto_expand_width = false,
        },
        filesystem = {
          follow_current_file = { enabled = true },
          hijack_netrw_behavior = 'disabled',
          use_libuv_file_watcher = true,
          components = {
            name = function(config, node, state)
              local components = require('neo-tree.sources.common.components')
              local name = components.name(config, node, state)
              if node:get_depth() == 1 then
                name.text = vim.fs.basename(vim.loop.cwd() or '')
              end
              return name
            end,
          },
        },
      })
    end,
  },
  {
    'antosha417/nvim-lsp-file-operations',
    cmd = 'Neotree',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-neo-tree/neo-tree.nvim', -- makes sure that this loads after Neo-tree.
    },
    config = function()
      require('lsp-file-operations').setup()
    end,
  },
  {
    's1n7ax/nvim-window-picker',
    version = '2.*',
    cmd = 'Neotree',
    opts = {
      filter_rules = {
        autoselect_one = true,
        include_current_win = false,
        bo = {
          filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
          buftype = { 'terminal', 'quickfix' },
        },
      },
    },
  },
}
