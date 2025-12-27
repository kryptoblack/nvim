---@type Snacks
local snacks = require('snacks')

snacks.setup({
  dashboard = {
    enabled = true,
  },
  picker = {
    enable = true,
    layout = {
      preset = 'ivy',
    },
  },
})
