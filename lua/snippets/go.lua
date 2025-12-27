local ls = require('luasnip')

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s('main', {
    t({ 'func main {', '\t' }),
    i(1),
    t({ '', '}' }),
  }),
  s('init', {
    t({ 'func init {', '\t' }),
    i(1),
    t({ '', '}' }),
  }),
  s('en', {
    t({ 'err != nil {', '\t' }),
    i(1),
    t({ '', '}' }),
  }),
}
