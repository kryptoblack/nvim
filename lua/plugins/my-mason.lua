return {
  { 'williamboman/mason.nvim', event = 'VeryLazy', opts = {} },
  {
    'williamboman/mason-lspconfig.nvim',
    event = 'VeryLazy',
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    opts = {
      ensure_installed = {
        'lua_ls',
        'gopls',
        'pyright',
        'ts_ls',
      },
    },
  },
}
