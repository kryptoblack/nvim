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
vim.keymap.set("n", "<leader>t", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })
vim.keymap.set("n", "<leader>o", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file tree" })

-- Luasnip
local ls = require("luasnip")
vim.keymap.set({ "i", "s" }, "<C-j>", function()
	if ls.jumpable(1) then
		ls.jump(1)
	end
end, { silent = true, desc = "LuaSnip jump forward" })
vim.keymap.set({ "i", "s" }, "<C-k>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true, desc = "LuaSnip jump backward" })

-- Folding
for i = 1, 5 do
	vim.keymap.set("n", "z" .. i, function()
		vim.opt.foldlevel = i
	end, { desc = "Fold level " .. i })
end

-- Buffer
vim.keymap.set("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Delete current buffer" })

-- Snacks
local snacks = require("snacks")
vim.keymap.set("n", "<leader>ff", snacks.picker.files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fr", snacks.picker.recent, { desc = "Recent files" })
vim.keymap.set("n", "<leader>fg", snacks.picker.grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fs", snacks.picker.lsp_symbols, { desc = "LSP symbols" })
vim.keymap.set("n", "<leader>ft", function() snacks.picker.todo_comments() end, { desc = "TODO picker" })
vim.keymap.set("n", "<leader>fd", function()
	snacks.picker.diagnostics({ bufnr = 0 })
end, { desc = "Diagnostics (buffer)" })
vim.keymap.set("n", "<leader>fD", snacks.picker.diagnostics, { desc = "Diagnostics (workspace)" })
vim.keymap.set("n", "<leader>fB", snacks.picker.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fb", function()
	snacks.picker.buffers({
		sort_lastused = true,
		layout = { preset = "ivy" },
	})
end, { desc = "Buffers (Recent Activity)" })

-- Gitsigns
local gs = require("gitsigns")
vim.keymap.set("n", "]gh", gs.next_hunk, { desc = "Next git hunk" })
vim.keymap.set("n", "[gh", gs.prev_hunk, { desc = "Previous git hunk" })
vim.keymap.set("n", "<leader>ghs", gs.stage_hunk, { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>ghr", gs.reset_hunk, { desc = "Reset hunk" })
vim.keymap.set("n", "<leader>ghR", gs.undo_stage_hunk, { desc = "Reset staged hunk" })
vim.keymap.set("n", "<leader>gB", gs.blame, { desc = "Preview blame" })
vim.keymap.set("n", "<leader>gb", gs.blame_line, { desc = "Preview blame line" })
vim.keymap.set("n", "<leader>gs", gs.stage_buffer, { desc = "Stage entire buffer" })

-- Diffview
vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Diffview: open" })
vim.keymap.set("n", "<leader>gD", "<cmd>DiffviewClose<CR>", { desc = "Diffview: close" })
vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", { desc = "Diffview: current file history" })
vim.keymap.set("n", "<leader>gH", "<cmd>DiffviewFileHistory<CR>", { desc = "Diffview: file history" })

-- Undotree
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "Undo tree" })
