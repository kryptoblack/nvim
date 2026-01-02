local function on_attach()
  local luasnip = require('luasnip')

  require('luasnip.loaders.from_vscode').lazy_load()
  require('luasnip.loaders.from_lua').lazy_load({
    paths = { vim.fn.stdpath('config') .. '/lua/snippets' },
  })

  luasnip.config.set_config({
    history = true,
    updateevents = 'TextChanged,TextChangedI',
    enable_autosnippets = false,
  })
end

return {
  'L3MON4D3/LuaSnip',
  lazy = true,
  dependencies = {
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',
  },
  config = on_attach,
}
