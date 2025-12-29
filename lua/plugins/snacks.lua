---@type Snacks
local snacks = require('snacks')

local header = [[
██╗   ██╗███████╗ ██████╗ ██████╗ ██████╗ ███████╗
██║   ██║██╔════╝██╔════╝██╔═══██╗██╔══██╗██╔════╝
██║   ██║███████╗██║     ██║   ██║██║  ██║█████╗  
╚██╗ ██╔╝╚════██║██║     ██║   ██║██║  ██║██╔══╝  
 ╚████╔╝ ███████║╚██████╗╚██████╔╝██████╔╝███████╗
  ╚═══╝  ╚══════╝ ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝]]

snacks.setup({
  dashboard = {
    enabled = true,
    preset = {
      pick = false,
      header = header,
      keys = {
        {
          icon = ' ',
          key = 'f',
          desc = 'Find File',
          action = ":lua Snacks.dashboard.pick('files')",
        },
        { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
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
          action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
        },
        {
          icon = ' ',
          key = 's',
          desc = 'Restore Session',
          action = function() end,
          enabled = true,
        },
        {
          icon = '󰒲 ',
          key = 'L',
          desc = 'Lazy',
          action = ':Lazy',
          enabled = package.loaded.lazy ~= nil,
        },
        { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
      },
    },

    sections = {
      { section = 'header' },
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
      { section = 'startup' },
    },
  },
  picker = {
    enable = true,
    layout = {
      preset = 'ivy',
    },
  },
})
