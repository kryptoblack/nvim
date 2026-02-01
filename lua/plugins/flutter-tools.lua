return {
  'nvim-flutter/flutter-tools.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/dressing.nvim',
  },
  config = true,
  opts = {
    fvm = true,
    lsp = {
      on_attach = require('utils.lsp-on-attach'),
    },
  },
}
