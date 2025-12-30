-- Leader keys (must be first)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Plugins
require('plugins')
require('plugins.mason')
require('plugins.lsp')
-- require('plugins.treesitter')
require('plugins.none-ls')
require('plugins.cmp')
require('plugins.snippet')
require('plugins.lualine')
require('plugins.colorscheme')
-- require('plugins.nvim-tree')
require('plugins.comment')
require('plugins.surround')
require('lua.plugins.my-snacks')
require('plugins.todo')
require('plugins.git-signs')
require('plugins.diffview')
require('lua.plugins.my-harpoon')
require('plugins.notify')
require('plugins.smear-cursor')

-- Core configuration
require('config.options')
require('config.keymaps')
require('config.autocmds')
require('config.diagnostics')
require('config.cmds')
