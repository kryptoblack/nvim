local M = {}

function M.format(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()

	vim.lsp.buf.format({
		bufnr = bufnr,
		filter = function(client)
			if client.name == "null-ls" then
				return true
			end

			-- fallback to LSP only if null-ls formatter is not attached
			for _, c in ipairs(vim.lsp.get_active_clients({bufnr = bufnr})) do
				if c.name == "null-ls" then
					return false
				end
			end

			return true
		end,
	})
end

return M
