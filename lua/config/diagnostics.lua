vim.diagnostic.config({
	severity_sort = true,

	virtual_text = {
		spacing = 4,
		prefix = "●"
	},

	signs = true,
	underline = true,
	update_in_insert = false,

	float = {
		border = "rounded",
		source = "if_many",
		header = "",
		prefix = "",
	}
})

local signs = {
	Error = "E",
	Warn  = "W",
	Hint  = "H",
	Info  = "I",
}

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
