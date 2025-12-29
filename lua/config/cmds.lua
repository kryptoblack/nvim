-- Task
vim.api.nvim_create_user_command('TaskCwd', function()
  require('utils.tasks').cwd.prompt()
end, { desc = 'Change current working directory for task' })
