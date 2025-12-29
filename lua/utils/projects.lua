---@class Project
local M = {}

local _root ---@type string|nil

local function resolve_root()
  if _root then
    return _root
  end

  local root = vim.fs.root(0, { '.git' })
  if not root then
    vim.notify(
      'No .git directory found. One NVIM instance must map to exactly one project.',
      vim.log.levels.ERROR
    )
    return nil
  end

  _root = vim.fn.fnamemodify(root, ':p')
  return _root
end

-- Absolute project root
function M.root()
  return resolve_root()
end

-- Project name (directory name)
function M.name()
  local root = M.root()
  if not root then
    return nil
  end
  return vim.fn.fnamemodify(root, ':t')
end

-- Stable project id (for persistence)
function M.id()
  local root = M.root()
  if not root then
    return nil
  end
  return vim.fn.sha256(root):sub(1, 12)
end

function M.is_valid()
  return M.root() ~= nil
end

return M
