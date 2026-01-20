local function has_biome(u)
  return u.root_has_file({ 'biome.json', 'biome.jsonc' })
end

local function has_prettier(u)
  return u.root_has_file({
    '.prettierrc',
    '.prettierrc.json',
    '.prettierrc.js',
    'prettier.config.js',
  })
end

local function on_attach()
  local null_ls = require('null-ls')
  local utils = require('null-ls.utils')

  null_ls.setup({
    sources = {
      -- Go
      null_ls.builtins.formatting.gofmt,
      null_ls.builtins.formatting.goimports,

      -- Python
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.isort,

      -- JS / TS
      null_ls.builtins.formatting.biome.with({
        prefer_local = true,
        condition = function()
          local conditional_utils = utils.make_conditional_utils()
          return has_biome(conditional_utils)
        end,
      }),

      null_ls.builtins.formatting.prettier.with({
        prefer_local = true,
        condition = function()
          local conditional_utils = utils.make_conditional_utils()
          return has_prettier(conditional_utils) and not has_biome(conditional_utils)
        end,
      }),

      -- Shell
      null_ls.builtins.formatting.shfmt,

      -- Lua
      null_ls.builtins.formatting.stylua,
    },
  })
end

return {
  'nvimtools/none-ls.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = on_attach,
}
