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
  { 'kylechui/nvim-surround', event = 'InsertEnter', opts = {} },

  -- Multiple cursors
  { 'mg979/vim-visual-multi', event = 'VeryLazy' },

  -- Picker & more
  require('plugins.my-snacks'),

  -- Git
  require('plugins.my-gitsigns'),
  require('plugins.my-diffview'),

  -- Undotree
  { 'mbbill/undotree', cmd = 'UndotreeToggle' },

  -- Harpoon
  require('plugins.my-harpoon'),

  -- Notify & LSP progress
  { 'j-hui/fidget.nvim', event = 'VeryLazy', dependencies = { 'nvim-lspconfig' }, opts = {} },

  -- Smear cursor
  -- require('plugins.smear-cursor'),

  -- wakatime
  { 'wakatime/vim-wakatime', lazy = false },

  -- Showkeys
  require('plugins.showkeys'),

  -- Autopairs
  { 'windwp/nvim-autopairs', event = 'InsertEnter', config = true, opts = {} },

  -- Sessions
  require('plugins.sessions'),

  -- Folding
  require('plugins.origami'),

  -- abolish
  { 'tpope/vim-abolish', event = 'VeryLazy' },

  -- Flutter tools
  require('plugins.flutter-tools'),

  -- GitHub copilot
  { 'github/copilot.vim' },
}, opts)
