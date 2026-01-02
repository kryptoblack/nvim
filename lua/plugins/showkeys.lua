return {
  'nvzone/showkeys',
  event = 'VeryLazy',
  opts = {
    winopts = {
      border = 'rounded',
    },
    position = 'bottom-center',
    show_count = true,
    timeout = 1,
    maxkeys = 5,
  },
  config = function(_, opts)
    require('showkeys').setup(opts)
    vim.cmd('ShowkeysToggle')
  end,
}
