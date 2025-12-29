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
vim.keymap.set('n', '<leader>gr', function()
  local file = vim.fn.expand('%')
  vim.system({ 'git', 'restore', file }, {}, function(obj)
    if obj.code == 0 then
      vim.schedule(function()
        vim.cmd('edit!')
        print('Restored: ' .. file)
      end)
    else
      vim.notify('Failed to perform git restore on file: ' .. file, vim.log.levels.ERROR)
    end
  end)
end, { desc = 'Restore current file' })
vim.keymap.set('n', '<leader>gu', function()
  local file = vim.fn.expand('%')
  vim.system({ 'git', 'restore', '--staged', file }, {}, function(obj)
    if obj.code == 0 then
      vim.schedule(function()
        vim.cmd('edit!')
        print('Restored: ' .. file)
      end)
    else
      vim.notify('Failed to perform unstage on file: ' .. file, vim.log.levels.ERROR)
    end
  end)
end, { desc = 'Unstage current file' })
vim.keymap.set('n', '<leader>gB', gs.blame, { desc = 'Preview blame' })
vim.keymap.set('n', '<leader>gb', gs.blame_line, { desc = 'Preview blame line' })
vim.keymap.set('n', '<leader>gs', gs.stage_buffer, { desc = 'Stage entire buffer' })

-- Explorer
vim.keymap.set('n', '<leader>e', function()
  local ok, diffview = pcall(require, 'diffview.lib')

  if ok and diffview.get_current_view() then
    vim.cmd('DiffviewToggleFiles')
    return
  end

  -- vim.cmd('NvimTreeToggle')
  vim.cmd('Neotree toggle=true')
end, { desc = '[E]xplorer (Diffview / NvimTree)' })

-- Diffview

---Helper function to toggle diffview windows
---@param open fun(): nil
---@return nil
local function diffview_toggle(open)
  if next(require('diffview.lib').views) == nil then
    open()
  else
    vim.cmd('DiffviewClose')
  end
end
vim.keymap.set('n', '<leader>gd', function()
  diffview_toggle(function()
    vim.cmd('DiffviewOpen')
  end)
end, { desc = '[G]it [d]iff toggle', noremap = true })
vim.keymap.set('n', '<leader>gh', function()
  diffview_toggle(function()
    vim.cmd('DiffviewFileHistory %')
  end)
end, { desc = 'Toggle [g]it [h]istory for file', noremap = true })
vim.keymap.set('n', '<leader>gH', function()
  diffview_toggle(function()
    vim.cmd('DiffviewFileHistory')
  end)
end, { desc = 'Toggle [g]it [h]istory', noremap = true })

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
vim.keymap.set('n', '<leader>tcd', ':TaskCwd<CR>', { desc = 'Task change directory' })
vim.keymap.set('n', '<leader>tca', ':tabonly<CR>', { desc = 'Close all tabs other than current' })
vim.keymap.set('n', '<leader>tw', '<C-w>T', { desc = 'Move window to new tab' })

-- textobjects
vim.keymap.set({ 'x', 'o' }, 'af', function()
  require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects')
end)
vim.keymap.set({ 'x', 'o' }, 'if', function()
  require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects')
end)
vim.keymap.set({ 'x', 'o' }, 'ac', function()
  require('nvim-treesitter-textobjects.select').select_textobject('@class.outer', 'textobjects')
end)
vim.keymap.set({ 'x', 'o' }, 'ic', function()
  require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects')
end)
-- You can also use captures from other query groups like `locals.scm`
vim.keymap.set({ 'x', 'o' }, 'as', function()
  require('nvim-treesitter-textobjects.select').select_textobject('@local.scope', 'locals')
end)

vim.keymap.set('n', '<leader>a', function()
  require('nvim-treesitter-textobjects.swap').swap_next('@parameter.inner')
end)
vim.keymap.set('n', '<leader>A', function()
  require('nvim-treesitter-textobjects.swap').swap_next('@parameter.outer')
end)

vim.keymap.set({ 'n', 'x', 'o' }, ']m', function()
  require('nvim-treesitter-textobjects.move').goto_next_start('@function.outer', 'textobjects')
end)
vim.keymap.set({ 'n', 'x', 'o' }, ']]', function()
  require('nvim-treesitter-textobjects.move').goto_next_start('@class.outer', 'textobjects')
end)
-- You can also pass a list to group multiple queries.
vim.keymap.set({ 'n', 'x', 'o' }, ']o', function()
  move.goto_next_start({ '@loop.inner', '@loop.outer' }, 'textobjects')
end)
-- You can also use captures from other query groups like `locals.scm` or `folds.scm`
vim.keymap.set({ 'n', 'x', 'o' }, ']s', function()
  require('nvim-treesitter-textobjects.move').goto_next_start('@local.scope', 'locals')
end)
vim.keymap.set({ 'n', 'x', 'o' }, ']z', function()
  require('nvim-treesitter-textobjects.move').goto_next_start('@fold', 'folds')
end)

vim.keymap.set({ 'n', 'x', 'o' }, ']M', function()
  require('nvim-treesitter-textobjects.move').goto_next_end('@function.outer', 'textobjects')
end)
vim.keymap.set({ 'n', 'x', 'o' }, '][', function()
  require('nvim-treesitter-textobjects.move').goto_next_end('@class.outer', 'textobjects')
end)

vim.keymap.set({ 'n', 'x', 'o' }, '[m', function()
  require('nvim-treesitter-textobjects.move').goto_previous_start('@function.outer', 'textobjects')
end)
vim.keymap.set({ 'n', 'x', 'o' }, '[[', function()
  require('nvim-treesitter-textobjects.move').goto_previous_start('@class.outer', 'textobjects')
end)

vim.keymap.set({ 'n', 'x', 'o' }, '[M', function()
  require('nvim-treesitter-textobjects.move').goto_previous_end('@function.outer', 'textobjects')
end)
vim.keymap.set({ 'n', 'x', 'o' }, '[]', function()
  require('nvim-treesitter-textobjects.move').goto_previous_end('@class.outer', 'textobjects')
end)

-- Go to either the start or the end, whichever is closer.
-- Use if you want more granular movements
vim.keymap.set({ 'n', 'x', 'o' }, ']d', function()
  require('nvim-treesitter-textobjects.move').goto_next('@conditional.outer', 'textobjects')
end)
vim.keymap.set({ 'n', 'x', 'o' }, '[d', function()
  require('nvim-treesitter-textobjects.move').goto_previous('@conditional.outer', 'textobjects')
end)
