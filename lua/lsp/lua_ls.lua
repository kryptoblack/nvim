M = {
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      workspace = {
        library = {
          -- TODO: add all nvim related runtime only if in nvim config
          vim.fn.expand(vim.env.VIMRUNTIME .. '/lua'),
          vim.fn.expand(vim.env.VIMRUNTIME .. '/lua/vim/lsp'),
          vim.fn.stdpath('data') .. '/lazy/lazy.nvim/lua/lazy',
          '${3rd}/luv/library', -- https://github.com/NvChad/NvChad/issues/2960
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

return M
