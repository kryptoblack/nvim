local ls = require('luasnip')

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s('pvi', {
    t({ 'print(vim.inspect(' }),
    i(1),
    t({ '))' }),
  }),
}
