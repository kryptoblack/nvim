local header = [[
██╗   ██╗███████╗ ██████╗ ██████╗ ██████╗ ███████╗
██║   ██║██╔════╝██╔════╝██╔═══██╗██╔══██╗██╔════╝
██║   ██║███████╗██║     ██║   ██║██║  ██║█████╗  
╚██╗ ██╔╝╚════██║██║     ██║   ██║██║  ██║██╔══╝  
 ╚████╔╝ ███████║╚██████╗╚██████╔╝██████╔╝███████╗
  ╚═══╝  ╚══════╝ ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝]]

local keys = {
  {
    icon = ' ',
    key = 'f',
    desc = 'Find File',
    action = ":lua Snacks.dashboard.pick('files')",
  },
  {
    icon = ' ',
    key = 'n',
    desc = 'New File',
    action = ':ene | startinsert',
  },
  {
    icon = ' ',
    key = 'g',
    desc = 'Find Text',
    action = ":lua Snacks.dashboard.pick('live_grep')",
  },
  {
    icon = ' ',
    key = 'r',
    desc = 'Recent Files',
    action = ":lua Snacks.dashboard.pick('oldfiles')",
  },
  {
    icon = ' ',
    key = 'c',
    desc = 'Config',
    action = function()
      require('utils.tmux-sessionizer').open(vim.fn.stdpath('config'))
    end,
  },
  {
    icon = ' ',
    key = 's',
    desc = 'Restore Session',
    section = 'session',
  },
  {
    icon = '󰒲 ',
    key = 'L',
    desc = 'Lazy',
    action = ':Lazy',
    enabled = package.loaded.lazy ~= nil,
  },
  { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
}

local function on_attach()
  local snacks = require('snacks')
  snacks.setup({
    dashboard = {
      enabled = true,
      preset = {
        pick = nil,
        header = header,
        keys = keys,
      },

      sections = {
        {
          pane = 1,

          { section = 'header', padding = 1 },

          {
            icon = ' ',
            title = 'Keymaps',
            section = 'keys',
            indent = 2,
            padding = 1,
          },

          function(_)
            return {
              icon = ' ',
              title = 'Projects',
              section = 'projects',
              indent = 2,
              padding = 1,
              limit = 5,
              key = 'o',
              action = function(value)
                if type(value) == 'string' then
                  require('utils.tmux-sessionizer').open(value)
                else
                  require('utils.tmux-sessionizer').open()
                end
              end,
              pick = false,
            }
          end,
        },
        { section = 'startup' },
      },
    },
    picker = {
      enabled = true,
      layout = {
        preset = 'ivy',
      },
    },
  })
end

return {
  'folke/snacks.nvim',
  config = on_attach,
  priority = 1000,
  lazy = false,
}
