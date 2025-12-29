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
    prompt = 'Task Name',
    completion = 'customlist,v:lua.TaskCompletion',
  }, callback)
end

return M
