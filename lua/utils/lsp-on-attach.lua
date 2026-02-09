lsp_on_attach = function(client, bufnr)
  if client.name ~= 'null-ls' then
    client.server_capabilities.documentFormatterProvider = false
  end

  local opts = { buffer = bufnr, silent = true }
  vim.keymap.set('n', 'gd', function()
    vim.lsp.buf.definition({ loclist = true })
  end, opts)
  vim.keymap.set('n', 'gr', function()
    vim.lsp.buf.references({ includeDeclaration = false })
  end, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
end

return lsp_on_attach
