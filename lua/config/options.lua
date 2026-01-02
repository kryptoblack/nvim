vim.opt.exrc = true
vim.opt.secure = true
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.opt.inccommand = 'nosplit'
vim.opt.showmode = false
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.clipboard = 'unnamedplus'
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.breakindent = true
vim.opt.cmdheight = 0
vim.opt.hidden = true
vim.opt.confirm = false

-- Timeout
vim.opt.timeout = true
vim.opt.timeoutlen = 500

-- Mouse
vim.opt.mouse = ''

-- Swap file
vim.opt.swapfile = false

-- Diff
vim.opt.diffopt:append('linematch:60')
vim.opt.diffopt:append('algorithm:histogram')

-- Smarter search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath('state') .. '/undo'

-- Cursor context
vim.opt.cursorline = false
vim.opt.cursorcolumn = false

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Wrapping
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- File explorer
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- vim-visual-multi settings
vim.g.VM_default_mappings = 1
vim.g.VM_silent_exit = 1
vim.g.VM_exit_on_esc = 1
vim.g.VM_reselect_first = 0
vim.g.VM_maps = {
  ['Find Under'] = '<C-n>',
  ['Find Subword Under'] = '<C-n>',
  ['Skip Region'] = '<C-s>',
  ['Remove Region'] = '<C-d>',
}

-- Folding
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldtext = "v:lua.require('utils.foldtext').foldtext()"
vim.opt.foldenable = true
vim.opt.foldlevel = 99 -- keep everything open
vim.opt.foldlevelstart = 99 -- no folds on file open
vim.opt.foldcolumn = '0' -- no extra gutter noise

-- Tabs
vim.opt.showtabline = 1
vim.opt.switchbuf = 'useopen'
vim.opt.splitright = true
vim.opt.splitbelow = true
