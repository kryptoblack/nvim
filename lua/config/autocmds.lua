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
