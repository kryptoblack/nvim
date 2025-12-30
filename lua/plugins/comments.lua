local function on_attach()
  require('Comment').setup({
    padding = true,
    sticky = true,

    pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),

    toggler = {
      line = 'gcc',
      block = 'gbc',
    },

    opleader = {
      line = 'gc',
      block = 'gb',
    },

    mappings = {
      basic = true,
      extra = true,
    },
  })
end

return {
  {
    'numToStr/Comment.nvim',
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    config = on_attach,
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    opts = { enable_autocmd = false },
  },
}
