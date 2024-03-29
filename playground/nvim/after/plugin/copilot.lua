vim.g.copilot_no_tab_map = true
vim.g.copilot_filetypes = { ["sh"] = false, ["go"] = false }
vim.api.nvim_set_keymap("i", "<C-K>", 'copilot#Previous()', { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Next()', { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-L>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-E>", 'copilot#Cancel()', { silent = true, expr = true })
