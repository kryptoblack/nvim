local M = {}

--- Format by prioritzing null-ls over lsp based formatting
---
--- @param bufnr? integer
function M.format(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  vim.lsp.buf.format({
    bufnr = bufnr,
    filter = function(client)
      if not client:supports_method('textDocument/formatting', bufnr) then
        return false
      end

      if client.name == 'null-ls' then
        return true
      end

      for _, c in pairs(clients) do
        if c.name == 'null-ls' then
          return false
        end
      end

      return true
    end,
  })
end

return M
