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
      header = header,
    },
    sections = {
      { section = 'header' },
      { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
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
