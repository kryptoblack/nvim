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
  require('plugins.lsp'),

  -- Treesitter
  require('plugins.treesitter'),

  -- Mason (LSP Package Manager)
  require('plugins.my-mason'),

  -- Formatting / linting
  require('plugins.none-ls'),

  -- Auto completion
  require('plugins.cmp'),

  -- Snippets
  require('plugins.snippets'),

  -- Colorscheme
  require('plugins.colorscheme'),

  -- Statusbar
  require('plugins.my-lualine'),

  -- Comments
  require('plugins.comments'),
  require('plugins.todo'),

  -- Surround
  { 'kylechui/nvim-surround', event = 'VeryLazy', opts = {} },

  -- Multiple cursors
  'mg979/vim-visual-multi',

  -- Picker
  require('plugins.my-snacks'),

  -- Git
  require('plugins.my-gitsigns'),
  require('plugins.my-diffview'),

  -- Undotree
  { 'mbbill/undotree', cmd = 'UndotreeToggle' },

  -- Harpoon
  require('plugins.my-harpoon'),

  -- Notify & LSP progress
  { 'j-hui/fidget.nvim', dependencies = { 'nvim-lspconfig' } },

  -- Smear cursor
  require('plugins.smear-cursor'),

  -- wakatime
  { 'wakatime/vim-wakatime', lazy = false },

  -- Neotree
  require('plugins.neotree'),

  -- Showkeys
  require('plugins.showkeys'),
}, opts)
