local servers = {
  gopls = {},
  pyright = {},
  ts_ls = {},
  lua_ls = {
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
  },
}

local function on_attach()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  for server, config in pairs(servers) do
    vim.lsp.config(
      server,
      vim.tbl_deep_extend('force', {
        on_attach = require('utils.lsp-on-attach'),
        capabilities = capabilities,
      }, config)
    )
  end
end

return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  config = on_attach,
}
