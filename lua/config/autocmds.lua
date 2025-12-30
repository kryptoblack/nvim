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

local format = require('utils.format')
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('AutoFormat', { clear = true }),
  callback = function(args)
    if vim.b[args.buf].disable_autoformat then
      return
    end

    if vim.g.disable_autoformat then
      return
    end

    format.format()
  end,
})

-- Multi cursor
vim.api.nvim_create_autocmd('User', {
  pattern = 'visual_multi_exit',
  callback = function()
    vim.cmd('stopinsert')
  end,
})

-- Automatic directory creation on save
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    local dir = vim.fn.fnamemodify(vim.fn.expand('<afile>'), ':p:h')
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
    end
  end,
})

-- Highlight text on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Close loclist on select
-- This is done for lsp goto defination and references
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = function()
    vim.keymap.set('n', '<CR>', function()
      vim.cmd('ll')
      vim.cmd('lclose')
    end, { buffer = true })
  end,
})

-- Tabs
-- Autoapply cwd on tab switch
vim.api.nvim_create_autocmd('TabEnter', {
  callback = function()
    require('utils.tasks').cwd.apply()
  end,
})

-- Treesitter
-- https://www.reddit.com/r/neovim/comments/1kuj9xm/comment/mv93w7h/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Enable treesitter highlighting',
  pattern = require('config.constants').parsers,
  callback = function(ctx)
    local hasStarted = pcall(vim.treesitter.start) -- errors for filetypes with no parser

    -- indent
    local noIndent = {}
    if hasStarted and not vim.list_contains(noIndent, ctx.match) then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
