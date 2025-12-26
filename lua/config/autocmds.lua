-- Auto Format
--
-- Disable for Buffer :let b:disable_autoformat = v:true
-- Enable for Buffer :unlet b:disable_autoformat
--
-- Disable for Project :let g:disable_autoformat = v:true
-- Enable for Project :unlet g:disable_autoformat
--
-- Example local configuration (.nvim.lua):
-- vim.g.disable_autoformat = true

local format = require("utils.format")
vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("AutoFormat", { clear = true }),
	callback = function(args)
		if vim.b[args.buf].disable_autoformat then
			return
		end

		if vim.g.disable_autoformat then
			return
		end

		format.format()
	end
})
