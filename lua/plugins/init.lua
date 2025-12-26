local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"git@github.com:folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

-- Adds lazy path to runtimepath (rtp)
vim.opt.rtp:prepend(lazypath)

local opts = {
	rocks = {
		enabled = false
	},
	ui = {
		border = "rounded"
	},
}

require("lazy").setup({
	"nvim-lua/plenary.nvim",
	"neovim/nvim-lspconfig",

	-- Treesitter
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

	-- Mason (LSP Package Manager)
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",

	-- Formatting / linting
	"nvimtools/none-ls.nvim",

	-- Auto completion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
	},

	-- Colorscheme
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
	},

	-- Statusbar
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- File explorer
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- Comments
	"numToStr/Comment.nvim",
	"JoosepAlviste/nvim-ts-context-commentstring",
}, opts)
