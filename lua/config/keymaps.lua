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
vim.keymap.set({ 'i', 's' }, '<C-j>', function()
  if require('luasnip').jumpable(1) then
    require('luasnip').jump(1)
  end
end, { silent = true, desc = 'LuaSnip jump forward' })
vim.keymap.set({ 'i', 's' }, '<C-k>', function()
  if require('luasnip').jumpable(-1) then
    require('luasnip').jump(-1)
  end
end, { silent = true, desc = 'LuaSnip jump backward' })

-- Folding
for i = 1, 5 do
  vim.keymap.set('n', 'z' .. i, function()
    vim.opt.foldlevel = i
  end, { desc = 'Fold level ' .. i })
end

-- Buffer
vim.keymap.set('n', '<leader>ff', function()
  require('snacks').picker.files({ hidden = true })
end, { desc = 'Find files' })
vim.keymap.set('n', '<leader>fr', function()
  require('snacks').picker.recent()
end, { desc = 'Recent files' })
vim.keymap.set('n', '<leader>fg', function()
  require('snacks').picker.grep()
end, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>fs', function()
  require('snacks').picker.lsp_symbols()
end, { desc = 'LSP symbols' })
vim.keymap.set('n', '<leader>fd', function()
  require('snacks').picker.diagnostics({ bufnr = 0 })
end, { desc = 'Diagnostics (buffer)' })
vim.keymap.set('n', '<leader>fD', function()
  require('snacks').picker.diagnostics()
end, { desc = 'Diagnostics (workspace)' })
vim.keymap.set('n', '<leader>fb', function()
  require('snacks').picker.buffers()
end, { desc = 'Buffers' })
vim.keymap.set('n', '<leader>ft', function()
  require('snacks').picker.todo_comments()
end, { desc = 'TODO picker' })

-- Git
vim.keymap.set('n', ']gh', function()
  require('gitsigns').nav_hunk('next')
end, { desc = 'Next git hunk' })
vim.keymap.set('n', '[gh', function()
  require('gitsigns').nav_hunk('prev')
end, { desc = 'Previous git hunk' })
vim.keymap.set('n', '<leader>ghs', function()
  require('gitsigns').stage_hunk()
end, { desc = 'Stage hunk' })
vim.keymap.set('n', '<leader>ghr', function()
  require('gitsigns').reset_hunk()
end, { desc = 'Reset hunk' })
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
vim.keymap.set('n', '<leader>gB', function()
  require('gitsigns').blame()
end, { desc = 'Preview blame' })
vim.keymap.set('n', '<leader>gb', function()
  require('gitsigns').blame_line()
end, { desc = 'Preview blame line' })
vim.keymap.set('n', '<leader>gs', function()
  require('gitsigns').stage_buffer()
end, { desc = 'Stage entire buffer' })

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

vim.keymap.set('n', '<leader>a', function()
  require('harpoon'):list():add()
end, { desc = 'List all harpoon marks' })
vim.keymap.set('n', '<M-e>', function()
  require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())
end, { desc = 'Toggle quick menu' })

for i, k in pairs({ 'a', 's', 'd', 'f', 'g' }) do
  vim.keymap.set('n', '<M-' .. k .. '>', function()
    require('harpoon'):list():select(i)
  end, { desc = 'Go to mark (' .. i .. ')' })
end

-- Tabs
-- <n>gt: go to tab at position n
-- gt: go to next tab
-- gT: go to prev tab
local function rename_tab()
  vim.ui.input({ prompt = 'Tab name: ' }, function(name)
    if name and name ~= '' then
      vim.cmd('LualineRenameTab ' .. vim.fn.fnameescape(name))
    end
  end)
end
vim.keymap.set('n', '<leader>tr', rename_tab, { desc = 'Rename tab' })
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { desc = 'New tab' })
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { desc = 'Close tab' })
vim.keymap.set('n', '<leader>tcd', ':TaskCwd<CR>', { desc = 'Task change directory' })
vim.keymap.set('n', '<leader>tca', ':tabonly<CR>', { desc = 'Close all tabs other than current' })
vim.keymap.set('n', '<leader>tw', '<C-w>T', { desc = 'Move window to new tab' })

-- textobjects (https://www.josean.com/posts/nvim-treesitter-and-textobjects)
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
    local select = require('nvim-treesitter-textobjects.select')
    select.select_textobject(query, 'textobjects')
  end)
end

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
    require('nvim-treesitter-textobjects.swap').swap_next(query)
  end)
end
for key, query in pairs(swap_prev) do
  vim.keymap.set('n', key, function()
    require('nvim-treesitter-textobjects.swap').swap_previous(query)
  end)
end

local move_configs = {
  -- Next Start
  { key = ']k', query = '@call.outer', fn = 'goto_next_start' },
  { key = ']f', query = '@function.outer', fn = 'goto_next_start' },
  { key = ']c', query = '@class.outer', fn = 'goto_next_start' },
  { key = ']i', query = '@conditional.outer', fn = 'goto_next_start' },
  { key = ']l', query = '@loop.outer', fn = 'goto_next_start' },
  { key = ']s', query = '@scope', fn = 'goto_next_start', group = 'locals' },
  { key = ']z', query = '@fold', fn = 'goto_next_start', group = 'folds' },

  -- Next End
  { key = ']K', query = '@call.outer', fn = 'goto_next_end' },
  { key = ']F', query = '@function.outer', fn = 'goto_next_end' },
  { key = ']C', query = '@class.outer', fn = 'goto_next_end' },
  { key = ']I', query = '@conditional.outer', fn = 'goto_next_end' },
  { key = ']L', query = '@loop.outer', fn = 'goto_next_end' },

  -- Previous Start
  { key = '[k', query = '@call.outer', fn = 'goto_previous_start' },
  { key = '[f', query = '@function.outer', fn = 'goto_previous_start' },
  { key = '[c', query = '@class.outer', fn = 'goto_previous_start' },
  { key = '[i', query = '@conditional.outer', fn = 'goto_previous_start' },
  { key = '[l', query = '@loop.outer', fn = 'goto_previous_start' },

  -- Previous End
  { key = '[K', query = '@call.outer', fn = 'goto_previous_end' },
  { key = '[F', query = '@function.outer', fn = 'goto_previous_end' },
  { key = '[C', query = '@class.outer', fn = 'goto_previous_end' },
  { key = '[I', query = '@conditional.outer', fn = 'goto_previous_end' },
  { key = '[L', query = '@loop.outer', fn = 'goto_previous_end' },
}

for _, m in ipairs(move_configs) do
  vim.keymap.set({ 'n', 'x', 'o' }, m.key, function()
    local move = require('nvim-treesitter-textobjects.move')
    vim.cmd("normal! m'")
    move[m.fn](m.query, m.group or 'textobjects')
    vim.cmd('normal! zz')
  end, { desc = m.query })
end

-- movement
vim.keymap.set({ 'n', 'v' }, '<C-k>', '<cmd>Treewalker Up<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-l>', '<cmd>Treewalker Right<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-j>', '<cmd>Treewalker Down<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-h>', '<cmd>Treewalker Left<cr>', { silent = true })

-- swapping
-- vim.keymap.set('n', '<C-K>', '<cmd>Treewalker SwapUp<cr>', { silent = true })
-- vim.keymap.set('n', '<C-J>', '<cmd>Treewalker SwapDown<cr>', { silent = true })
-- vim.keymap.set('n', '<C-H>', '<cmd>Treewalker SwapLeft<cr>', { silent = true })
-- vim.keymap.set('n', '<C-L>', '<cmd>Treewalker SwapRight<cr>', { silent = true })

-- Sessions
vim.keymap.set('n', '<leader>qs', function()
  require('persistence').load()
end, { desc = 'load the session for the current directory' })
vim.keymap.set('n', '<leader>qS', function()
  require('persistence').select()
end, { desc = 'select a session to load' })
vim.keymap.set('n', '<leader>ql', function()
  require('persistence').load({ last = true })
end, { desc = 'load the last session' })
vim.keymap.set('n', '<leader>qd', function()
  require('persistence').stop()
end, {
  desc = "stop Persistence => session won't be saved on exit",
})

-- Move chucks of code up/down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv") -- Shift visual selected line down
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv") -- Shift visual selected line up
