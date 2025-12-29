---@class Task
local M = {}

--- Just a table of common tasks (suggestions)
local TASK_NAMES = {
  'CODE',
  'TEST',
  'DEBUG',
  'DB',
  'DOCS',
  'OPS',
  'REVIEW',
  'SCRATCH',
}

--- Global function used in task name completion
--- @param arglead string
--- @return string[]
function _G.TaskCompletion(arglead, _, _)
  return vim.tbl_filter(function(name)
    return vim.startswith(name:upper(), arglead:upper())
  end, TASK_NAMES)
end

--- Returns tabname
--- @return string | nil
M.get_name = function()
  return vim.t.tabname
end

--- Sets tabname
--- @param name string
--- @return boolean
M.set_name = function(name)
  if not name or name == '' then
    vim.notify('Tab name is empty', 'warn')
    return false
  end

  vim.t.tabname = name:upper()
  return true
end

--- Creates a new tab with provided name
--- @param name string
--- @return nil
M.new = function(name)
  vim.cmd('tabnew')
  M.set_name(name)
end

--- Uses an input prompt to rename tab
--- @return nil
M.rename = function()
  vim.ui.input({ prompt = 'Task tabname: ' }, function(name)
    M.set_name(name)
  end)
end

--- Prompt for task name with completion
--- Creates new tab if name does not exist
--- @return nil
M.pick = function()
  local callback = function(name)
    M.new(name)
  end

  vim.ui.input({
    prompt = 'Task tabname: ',
    completion = 'customlist,v:lua.TaskCompletion',
  }, callback)
end

M.nvim_tree = {}

---Sets root path for nvim tree
---@param path string
---@return nil
function M.nvim_tree.set_root(path)
  local ok, api = pcall(require, 'nvim-tree.api')
  if not ok then
    return
  end

  if not api.tree.is_visible() then
    return
  end

  api.tree.change_root(path)
end

M.cwd = {}
local project = require('utils.projects')

--- Apply task-local cwd for current tab
--- @return nil
function M.cwd.apply()
  local root = project.root()
  if not root then
    return
  end

  local rel = vim.t.cwd
  local cwd = root

  if rel and rel ~= '' then
    cwd = root .. '/' .. rel
  end

  vim.cmd('lcd ' .. vim.fn.fnameescape(cwd))
  M.nvim_tree.set_root(cwd)
end

---Set cwd for current task (relative to project root)
---@param rel any
---@return nil
function M.cwd.set(rel)
  if rel == '' then
    rel = nil
  end

  vim.t.cwd = rel
  M.cwd.apply()
end

--- Prompt and set cwd for current task
function M.cwd.prompt()
  local root = project.root()
  if not root then
    return
  end

  local default = vim.t.cwd or ''

  vim.ui.input({
    prompt = 'Task cwd (relative to project root): ',
    default = default,
    completion = 'dir',
  }, function(input)
    if input == nil then
      return
    end

    if input == '' then
      M.cwd.set(nil)
    else
      M.cwd.set(input)
    end
  end)
end

--- Creates a new task tab
---@param name string
---@param cwd string|nil
function M.cwd.new(name, cwd)
  vim.cmd('tabnew')
  vim.t.tabname = name
  M.cwd.set(cwd)
end

return M
