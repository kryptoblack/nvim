local servers = {
  gopls = {},
  pyright = {},
  ts_ls = {},
  lua_ls = require('lsp.lua_ls'),
  tailwindcss = {},
  cssls = require('lsp.cssls'),
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
