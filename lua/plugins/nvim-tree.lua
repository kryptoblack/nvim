require("nvim-tree").setup({
	disable_netrw = true,
	hijack_netrw = true,
	hijack_cursor = false,

	view = {
		width = 32,
		side = "left",
		preserve_window_proportions = true,
	},

	renderer = {
		highlight_git = true,
		root_folder_label = false,

		icons = {
			show = {
				git = true,
				file = true,
				folder = true,
				folder_arrow = false,
			},
		},
	},

	filters = {
		dotfiles = false,
	},

	git = {
		enable = true,
	},

	actions = {
		open_file = {
			quit_on_open = true,
		},
	},

	update_focused_file = {
		enable = true,
		update_root = false,
	},
})
