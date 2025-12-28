vim.api.nvim_create_user_command('TabRename', function(opts)
  vim.t.tabname = opts.args
end, { nargs = 1 })
