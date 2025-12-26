local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local on_attach = function(client, bufnr)
	if client.name ~= "null-ls" then
		client.server_capabilities.documentFormatterProvider = false
	end

	local opts = { buffer = bufnr, silent = true }

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
end

local servers = {
	gopls = {},
	pyright = {},
	ts_ls = {},
	lua_ls = {
		settings = {
			Lua = { diagnostics = { globals = { "vim" } } },
		}
	},
}

for server, config in pairs(servers) do
	vim.lsp.config(server, vim.tbl_deep_extend("force", {
		on_attach = on_attach,
		capabilities = capabilities,
	}, config))
end
