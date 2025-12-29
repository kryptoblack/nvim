local M = {}

local SESSIONIZER = vim.fn.expand('~/.config/tmux/tmux-sessionizer.bash')
local DEFAULT_TERMINAL = 'foot'

---Runs tmux-sessionizer
---@param path string?
---@return nil
function M.open(path)
  if vim.fn.executable(SESSIONIZER) == 0 then
    vim.notify('tmux-sessionizer not executable', vim.log.levels.ERROR)
    return
  end

  if vim.env.TMUX then
    vim.fn.jobstart({
      'tmux',
      'new-window',
      '-n',
      'sessionizer',
      SESSIONIZER,
      path,
    })
  else
    local terminal = vim.env.TERMINAL or DEFAULT_TERMINAL
    vim.fn.jobstart({
      'setsid',
      terminal,
      '-e',
      SESSIONIZER,
      path,
    }, {
      detach = true,
      stdout = 'null',
      stderr = 'null',
    })
  end
end

return M
