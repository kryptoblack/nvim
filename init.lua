-- Leader keys (must be first)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Plugins
require('lua.plugins.init')

-- Core configuration
require('config.options')
require('config.keymaps')
require('config.autocmds')
require('config.diagnostics')
require('config.cmds')
