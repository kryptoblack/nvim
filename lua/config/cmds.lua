-- Task
vim.api.nvim_create_user_command('TaskCwd', function()
  require('utils.tasks').cwd.prompt()
end, { desc = 'Change current working directory for task' })

vim.api.nvim_create_user_command('CwdDebug', function()
  print('Global cwd     :', vim.fn.getcwd())
  print('Window cwd     :', vim.fn.getcwd(0))
  print('Tab (derived)  :', vim.fn.getcwd(-1))
end, {})
