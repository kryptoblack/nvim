local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'git@github.com:folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end

-- Adds lazy path to runtimepath (rtp)
vim.opt.rtp:prepend(lazypath)

local opts = {
  rocks = {
    enabled = false,
  },
  ui = {
    border = 'rounded',
  },
}

require('lazy').setup({
  'nvim-lua/plenary.nvim',

  -- LSP
  require('lua.plugins.lsp'),

  -- Treesitter
  require('lua.plugins.treesitter'),

  -- Mason (LSP Package Manager)
  require('lua.plugins.my-mason'),

  -- Formatting / linting
  require('lua.plugins.none-ls'),

  -- Auto completion
  require('lua.plugins.cmp'),

  -- Snippets
  require('lua.plugins.snippets'),

  -- Colorscheme
  require('lua.plugins.colorscheme'),

  -- Statusbar
  require('lua.plugins.my-lualine'),

  -- Comments
  require('lua.plugins.comments'),
  require('lua.plugins.todo'),

  -- Surround
  'kylechui/nvim-surround',

  -- Multiple cursors
  'mg979/vim-visual-multi',

  -- Picker
  require('lua.plugins.my-snacks'),

  -- Git
  require('lua.plugins.my-gitsigns'),
  require('lua.plugins.my-diffview'),

  -- Undotree
  'mbbill/undotree',

  -- Harpoon
  require('lua.plugins.my-harpoon'),

  -- Notify & LSP progress
  { 'j-hui/fidget.nvim', dependencies = { 'nvim-lspconfig' } },

  -- Smear cursor
  require('lua.plugins.smear-cursor'),

  -- wakatime
  { 'wakatime/vim-wakatime', lazy = false },

  -- Neotree
  require('plugins.neotree'),

  -- Showkeys
  require('plugins.showkeys'),
}, opts)
