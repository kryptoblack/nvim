vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })
vim.keymap.set('n', '<leader>z', function()
  vim.opt.wrap = not vim.o.wrap
  print('Wrap is now ' .. (vim.o.wrap and 'on' or 'off'))
end, { desc = 'Toggle wrap' })

-- Change/Cut/Delete
vim.keymap.set({ 'n', 'v' }, 'd', '"_d', { noremap = true })
vim.keymap.set({ 'n', 'v' }, 'x', '"_x', { noremap = true })
vim.keymap.set({ 'n', 'v' }, 'c', '"_c', { noremap = true })
vim.keymap.set('n', 'D', '"_D', { noremap = true })
vim.keymap.set('n', 'C', '"_C', { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"+d', { desc = 'Cut to system clipboard' })
vim.keymap.set('n', '<leader>D', '"+D', { desc = 'Cut to system clipboard' })

-- Search direction
vim.keymap.set(
  'n',
  'N',
  "'nN'[v:searchforward]",
  { expr = true, desc = 'Move up regardless of forward/backward search' }
)
vim.keymap.set(
  'n',
  'n',
  "'Nn'[v:searchforward]",
  { expr = true, desc = 'Move down regardless of forward/backward search' }
)

-- Diagnostics
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open diagnostic message' })
vim.keymap.set('n', '[d', function()
  vim.diagnostic.goto_diagnostic(-1)
end, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']d', function()
  vim.diagnostic.goto_diagnostic(1)
end, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Formatting
local format = require('utils.format')
vim.keymap.set('n', '<leader>f', function()
  format.format()
end, { desc = 'Format buffer' })

-- File explorer
vim.keymap.set('n', '<C-b>', '<cmd>NvimTreeToggle<CR>', { desc = 'Smart NvimTree toggle' })

-- Luasnip
local ls = require('luasnip')
vim.keymap.set({ 'i', 's' }, '<C-j>', function()
  if ls.jumpable(1) then
    ls.jump(1)
  end
end, { silent = true, desc = 'LuaSnip jump forward' })
vim.keymap.set({ 'i', 's' }, '<C-k>', function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true, desc = 'LuaSnip jump backward' })

-- Folding
for i = 1, 5 do
  vim.keymap.set('n', 'z' .. i, function()
    vim.opt.foldlevel = i
  end, { desc = 'Fold level ' .. i })
end

-- Buffer
vim.keymap.set('n', '<leader>bd', '<cmd>bd<CR>', { desc = 'Delete current buffer' })

---@type Snacks
local snacks = require('snacks')
vim.keymap.set('n', '<leader>ff', function()
  snacks.picker.files({ hidden = true })
end, { desc = 'Find files' })
vim.keymap.set('n', '<leader>fr', snacks.picker.recent, { desc = 'Recent files' })
vim.keymap.set('n', '<leader>fg', snacks.picker.grep, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>fs', snacks.picker.lsp_symbols, { desc = 'LSP symbols' })
vim.keymap.set('n', '<leader>fd', function()
  snacks.picker.diagnostics({ bufnr = 0 })
end, { desc = 'Diagnostics (buffer)' })
vim.keymap.set('n', '<leader>fD', snacks.picker.diagnostics, { desc = 'Diagnostics (workspace)' })
vim.keymap.set('n', '<leader>fb', snacks.picker.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>ft', function()
  snacks.picker.todo_comments() ---@diagnostic disable-line: undefined-field
end, { desc = 'TODO picker' })

local gs = require('gitsigns')
vim.keymap.set('n', ']gh', function()
  gs.nav_hunk('next') ---@diagnostic disable-line: param-type-mismatch
end, { desc = 'Next git hunk' })
vim.keymap.set('n', '[gh', function()
  gs.nav_hunk('prev') ---@diagnostic disable-line: param-type-mismatch
end, { desc = 'Previous git hunk' })
vim.keymap.set('n', '<leader>ghs', gs.stage_hunk, { desc = 'Stage hunk' })
vim.keymap.set('n', '<leader>ghr', gs.reset_hunk, { desc = 'Reset hunk' })
vim.keymap.set('n', '<leader>gB', gs.blame, { desc = 'Preview blame' })
vim.keymap.set('n', '<leader>gb', gs.blame_line, { desc = 'Preview blame line' })
vim.keymap.set('n', '<leader>gs', gs.stage_buffer, { desc = 'Stage entire buffer' })

-- Diffview
vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewOpen<CR>', { desc = 'Diffview: open' })
vim.keymap.set('n', '<leader>gD', '<cmd>DiffviewClose<CR>', { desc = 'Diffview: close' })
vim.keymap.set(
  'n',
  '<leader>gh',
  '<cmd>DiffviewFileHistory %<CR>',
  { desc = 'Diffview: current file history' }
)
vim.keymap.set(
  'n',
  '<leader>gH',
  '<cmd>DiffviewFileHistory<CR>',
  { desc = 'Diffview: file history' }
)

-- Undotree
vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<CR>', { desc = 'Undo tree' })

---@type Harpoon
local harpoon = require('harpoon')
vim.keymap.set('n', '<leader>a', function()
  harpoon:list():add()
end, { desc = 'List all harpoon marks' })
vim.keymap.set('n', '<M-e>', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = 'Toggle quick menu' })

for i = 1, 10, 1 do
  vim.keymap.set('n', '<M-' .. i .. '>', function()
    harpoon:list():select(i)
  end, { desc = 'Go to mark (' .. i .. ')' })
end

-- Tabs
-- <n>gt: go to tab at position n
-- gt: go to next tab
-- gT: go to prev tab
local tasks = require('utils.tasks')
vim.keymap.set('n', '<leader>tr', tasks.rename, { desc = 'Rename tab' })
vim.keymap.set('n', '<leader>tn', tasks.pick, { desc = 'New project workspace' })
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { desc = 'Close tab' })
vim.keymap.set('n', '<leader>tca', ':tabonly<CR>', { desc = 'Close all tabs other than current' })
vim.keymap.set('n', '<leader>tw', '<C-w>T', { desc = 'Move window to new tab' })
