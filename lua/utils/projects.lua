local M = {}

local _root = nil

---Used to find the root of project
---@return string | nil
function M.root()
  if _root then
    return _root
  end

  local git_root = vim.fn.root(0, { '.git' })
  if not git_root then
    vim.notify(
      'No .git directory found. NVIM expects one project per instance.',
      vim.log.levels.ERROR
    )
    return nil
  end

  _root = vim.fn.fnamemodify(git_root, ':p')
  return _root
end

---Get human readable name
---@return string | nil
function M.name()
  local root = M.root()
  if not root then
    return nil
  end
  return vim.fn.fnamemodify(root, ':t')
end

---Get hash value of root path for unique identification
---@return string | nil
function M.id()
  local root = M.root()
  if not root then
    return nil
  end
  return vim.fn.sha256(root):sub(1, 12)
end

---Validity guard function for consumer
---@return boolean
function M.is_valid()
  return M.root() ~= nil
end

M.root()
return M
