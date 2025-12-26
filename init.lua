-- Leader keys (must be first)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Core configuration
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.diagnostics")

-- Plugins
require("plugins")
require("plugins.mason")
require("plugins.lsp")
require("plugins.treesitter")
require("plugins.none-ls")
require("plugins.cmp")
require("plugins.statusbar")
require("plugins.colorscheme")
require("plugins.nvim-tree")
require("plugins.comment")
