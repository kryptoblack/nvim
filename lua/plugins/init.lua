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
  'neovim/nvim-lspconfig',

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
  },

  -- Mason (LSP Package Manager)
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',

  -- Formatting / linting
  'nvimtools/none-ls.nvim',

  -- Auto completion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'dnnr1/lorem-ipsum.nvim',
      'hrsh7th/cmp-nvim-lua',
    },
  },
  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
    },
  },

  -- Colorscheme
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
  },

  -- Statusbar
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },

  -- File explorer
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },

  -- Comments
  'numToStr/Comment.nvim',
  'JoosepAlviste/nvim-ts-context-commentstring',
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  -- Surround
  'kylechui/nvim-surround',

  -- Multiple cursors
  'mg979/vim-visual-multi',

  -- Picker
  'folke/snacks.nvim',

  -- Git
  'lewis6991/gitsigns.nvim',
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  -- Undotree
  'mbbill/undotree',

  -- Harpoon
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  -- Notify & LSP progress
  { 'j-hui/fidget.nvim', dependencies = { 'nvim-lspconfig' } },

  -- Smear cursor
  'sphamba/smear-cursor.nvim',

  -- wakatime
  { 'wakatime/vim-wakatime', lazy = false },
}, opts)
