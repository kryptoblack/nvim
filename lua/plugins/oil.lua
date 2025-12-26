local oil = require("oil")

oil.setup({
	default_file_explorer = true,
	columns = {
		"icon",
		"permissions",
		"size",
		"mtime",
	},
	skip_confirm_for_simple_edits = true,
	delete_to_trash = true,

	view = {
		preview = true
	}
})
