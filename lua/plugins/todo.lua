local todo = require('todo-comments')

todo.setup({
  signs = false,

  keywords = {
    TODO = { color = 'info' },
    FIXME = { color = 'error' },
    ERROR = { color = 'error' },
    WARN = { color = 'warning' },
    NOTE = { color = 'hint' },
    HACK = { color = 'warning' },
  },

  highlight = {
    before = ' ',
    keyword = 'wide',
    after = 'fg',
    pattern = [[.*<(KEYWORDS)\s*:]],
  },

  search = {
    command = 'rg',
    args = {
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
    },
    pattern = [[\b(KEYWORDS):]],
  },
})
