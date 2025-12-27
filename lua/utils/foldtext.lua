local M = {}

function M.foldtext()
  local start_line = vim.fn.getline(vim.v.foldstart)
  -- local end_line = vim.fn.getline(vim.v.foldend)
  local line_count = vim.v.foldend - vim.v.foldstart + 1

  -- Clean up whitespace
  start_line = start_line:gsub('^%s+', ''):gsub('%s+$', '')

  -- Truncate long lines
  local max_len = math.floor(vim.o.columns * 0.6)
  if #start_line > max_len then
    start_line = start_line:sub(1, max_len) .. '…'
  end

  return string.format(' %s ── %d lines ', start_line, line_count)
end

return M
