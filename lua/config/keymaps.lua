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
  vim.diagnostic.jump({ count = -1 })
end, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump({ count = 1 })
end, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float, { desc = 'Diagnostics' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setqflist)
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist)

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

local snacks = require('snacks')
vim.keymap.set('n', '<leader>sf', function()
  snacks.picker.files({ hidden = true })
end, { desc = 'Find files' })
vim.keymap.set('n', '<leader>sr', snacks.picker.recent, { desc = 'Recent files' })
vim.keymap.set('n', '<leader>sg', snacks.picker.grep, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>ss', snacks.picker.lsp_symbols, { desc = 'LSP symbols' })
vim.keymap.set('n', '<leader>sd', function()
  snacks.picker.diagnostics({ bufnr = 0 })
end, { desc = 'Diagnostics (buffer)' })
vim.keymap.set('n', '<leader>sD', snacks.picker.diagnostics, { desc = 'Diagnostics (workspace)' })
vim.keymap.set('n', '<leader>sb', snacks.picker.buffers, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>st', function()
  snacks.picker.todo_comments()
end, { desc = 'TODO picker' })

local gs = require('gitsigns')
vim.keymap.set('n', ']gh', function()
  gs.nav_hunk('next')
end, { desc = 'Next git hunk' })
vim.keymap.set('n', '[gh', function()
  gs.nav_hunk('prev')
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

local harpoon = require('harpoon')
vim.keymap.set('n', '<leader>a', function()
  harpoon:list():add()
end, { desc = 'List all harpoon marks' })
vim.keymap.set('n', '<M-e>', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = 'Toggle quick menu' })

for i, k in pairs({ 'a', 's', 'd', 'f', 'g' }) do
  vim.keymap.set('n', '<M-' .. k .. '>', function()
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

-- textobjects (https://www.josean.com/posts/nvim-treesitter-and-textobjects)
local tst_select = require('nvim-treesitter-textobjects.select')

local select_maps = {
  ['a='] = '@assignment.outer',
  ['i='] = '@assignment.inner',
  ['l='] = '@assignment.lhs',
  ['r='] = '@assignment.rhs',
  ['aa'] = '@parameter.outer',
  ['ia'] = '@parameter.inner',
  ['ai'] = '@conditional.outer',
  ['ii'] = '@conditional.inner',
  ['al'] = '@loop.outer',
  ['il'] = '@loop.inner',
  ['ak'] = '@call.outer',
  ['ik'] = '@call.inner',
  ['af'] = '@function.outer',
  ['if'] = '@function.inner',
  ['am'] = '@method.outer',
  ['im'] = '@method.inner',
  ['ac'] = '@class.outer',
  ['ic'] = '@class.inner',
}

for key, query in pairs(select_maps) do
  vim.keymap.set({ 'x', 'o' }, key, function()
    tst_select.select_textobject(query, 'textobjects')
  end)
end

local tst_swap = require('nvim-treesitter-textobjects.swap')

local swap_next = {
  ['<leader>na'] = '@parameter.inner',
  ['<leader>nf'] = '@function.outer',
}
local swap_prev = {
  ['<leader>pa'] = '@parameter.inner',
  ['<leader>pf'] = '@function.outer',
}

for key, query in pairs(swap_next) do
  vim.keymap.set('n', key, function()
    tst_swap.swap_next(query)
  end)
end
for key, query in pairs(swap_prev) do
  vim.keymap.set('n', key, function()
    tst_swap.swap_previous(query)
  end)
end

local tst_move = require('nvim-treesitter-textobjects.move')

local move_configs = {
  -- Next Start
  { key = ']k', query = '@call.outer', func = tst_move.goto_next_start },
  { key = ']f', query = '@function.outer', func = tst_move.goto_next_start },
  { key = ']c', query = '@class.outer', func = tst_move.goto_next_start },
  { key = ']i', query = '@conditional.outer', func = tst_move.goto_next_start },
  { key = ']l', query = '@loop.outer', func = tst_move.goto_next_start },
  { key = ']s', query = '@scope', func = tst_move.goto_next_start, group = 'locals' },
  { key = ']z', query = '@fold', func = tst_move.goto_next_start, group = 'folds' },

  -- Next End
  { key = ']K', query = '@call.outer', func = tst_move.goto_next_end },
  { key = ']F', query = '@function.outer', func = tst_move.goto_next_end },
  { key = ']C', query = '@class.outer', func = tst_move.goto_next_end },
  { key = ']I', query = '@conditional.outer', func = tst_move.goto_next_end },
  { key = ']L', query = '@loop.outer', func = tst_move.goto_next_end },

  -- Previous Start
  { key = '[k', query = '@call.outer', func = tst_move.goto_previous_start },
  { key = '[f', query = '@function.outer', func = tst_move.goto_previous_start },
  { key = '[c', query = '@class.outer', func = tst_move.goto_previous_start },
  { key = '[i', query = '@conditional.outer', func = tst_move.goto_previous_start },
  { key = '[l', query = '@loop.outer', func = tst_move.goto_previous_start },

  -- Previous End
  { key = '[K', query = '@call.outer', func = tst_move.goto_previous_end },
  { key = '[F', query = '@function.outer', func = tst_move.goto_previous_end },
  { key = '[C', query = '@class.outer', func = tst_move.goto_previous_end },
  { key = '[I', query = '@conditional.outer', func = tst_move.goto_previous_end },
  { key = '[L', query = '@loop.outer', func = tst_move.goto_previous_end },
}

for _, m in ipairs(move_configs) do
  vim.keymap.set({ 'n', 'x', 'o' }, m.key, function()
    vim.cmd("normal! m'")
    m.func(m.query, m.group or 'textobjects')
    vim.cmd('normal! zz')
  end, { desc = m.desc or m.query })
end
