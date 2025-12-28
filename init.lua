-- Leader keys (must be first)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Plugins
require('plugins')
require('plugins.mason')
require('plugins.lsp')
require('plugins.treesitter')
require('plugins.none-ls')
require('plugins.cmp')
require('plugins.snippet')
require('plugins.lualine')
require('plugins.colorscheme')
require('plugins.nvim-tree')
require('plugins.comment')
require('plugins.surround')
require('plugins.picker')
require('plugins.todo')
require('plugins.git-signs')
require('plugins.git-diffview')
require('plugins.harpoon')
require('plugins.notify')
require('plugins.smear-cursor')

-- Core configuration
require('config.options')
require('config.keymaps')
require('config.autocmds')
require('config.diagnostics')
require('config.cmds')
