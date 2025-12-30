local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local on_attach = function(client, bufnr)
  if client.name ~= 'null-ls' then
    client.server_capabilities.documentFormatterProvider = false
  end

  local opts = { buffer = bufnr, silent = true }
  vim.keymap.set('n', 'gd', function()
    vim.lsp.buf.definition({ loclist = true })
  end, opts)
  vim.keymap.set('n', 'gr', function()
    vim.lsp.buf.references({ includeDeclaration = false }, { loclist = true })
  end, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
end

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
            vim.fn.stdpath('data') .. '/site', -- Treesitter install dir
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

for server, config in pairs(servers) do
  vim.lsp.config(
    server,
    vim.tbl_deep_extend('force', {
      on_attach = on_attach,
      capabilities = capabilities,
    }, config)
  )
end
