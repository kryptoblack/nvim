require('nvim-treesitter.configs').setup({
	ensure_installed = {
		"go",
		"lua",
		"python",
		"javascript",
		"typescript",
		"json",
		"yaml",
		"bash",
	},

	auto_install = true,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},

	indent = {
		enable = true,
	},

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		}
	},

	textobjects = {
		-- Selection
		select = {
			enable = true,
			lookahead = true, -- automatically jump forward

			keymaps = {
				-- functions
				["af"] = "@function.outer",
				["if"] = "@function.inner",

				-- classes / types
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",

				-- blocks / scopes
				["ab"] = "@block.outer",
				["ib"] = "@block.inner",

				-- parameters
				["ap"] = "@parameter.outer",
				["ip"] = "@parameter.inner",
			},

			-- how selections behave
			selection_modes = {
				["@parameter.outer"] = "v",     -- charwise
				["@function.outer"]  = "V",     -- linewise
				["@class.outer"]     = "<c-v>", -- blockwise
			},

			include_surrounding_whitespace = true,
		},

		-- Movement
		move = {
			enable = true,
			set_jumps = true,

			goto_next_start = {
				["]f"] = "@function.outer",
				["]c"] = "@class.outer",
			},
			goto_previous_start = {
				["[f"] = "@function.outer",
				["[c"] = "@class.outer",
			},
		},
	},
})
