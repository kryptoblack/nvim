local comment = require("Comment")
local ts_context = require("ts_context_commentstring.integrations.custom_nvim")

comment.setup({
	padding = true,
	sticky = true,

	pre_hook = ts_context.create_pre_hook(),

	toggler = {
		line = "gcc",
		block = "gbc"
	},

	opleader = {
		line = "gc",
		block = "gb",
	},

	mappings = {
		basic = true,
		extra = true,
	},
})
