-- Diagnostics
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- Formatting
local format = require("utils.format")
vim.keymap.set("n", "<leader>f", function()
	format.format()
end, { desc = "Format buffer" })

-- File explorer
-- vim.keymap.set("n", "-", function()
-- 	require("oil").open()
-- end, { desc = "Open parent directory (oil)" })
vim.keymap.set("n", "<leader>w", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })
-- vim.keymap.set("n", "<leader>o", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file tree" })
