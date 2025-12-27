local comment = require('Comment')

require('ts_context_commentstring').setup({
  enable_autocmd = false,
})

comment.setup({
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
