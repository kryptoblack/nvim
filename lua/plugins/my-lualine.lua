local function on_attach()
  local lualine = require('lualine')
  lualine.setup({
    options = {
      icons_enabled = true,
      globalstatus = true,
      component_separators = '',
      section_separators = '',
      disabled_filetypes = {
        'snacks_dashboard',
        'neo-tree',
        'undotree',
        'diff',
      },
    },

    sections = {
      lualine_a = {
        { 'mode' },
      },
      lualine_b = {
        { 'branch' },
        { 'diff' },
      },
      lualine_c = {
        {
          'filename',
          file_status = true,
          newfile_status = true,
          path = 0,
          symbols = {
            modified = '●',
            alternate_file = '#',
            directory = '',
            readonly = '',
            unnamed = '[No Name]',
            newfile = '[New]',
          },
        },
      },
      lualine_x = {
        {
          'diagnostics',
          sections = { 'error', 'warn', 'info', 'hint' },
        },
        {
          'searchcount',
          maxcount = 999,
          timeout = 500,
        },
      },
      lualine_y = {
        {
          'fileformat',
          symbols = {
            unix = '',
            dos = '',
            mac = '',
          },
        },
        { 'filetype', icon_only = true },
        { 'encoding', show_bomb = false },
        { 'location' },
      },
      lualine_z = {
        { 'datetime', style = '%l:%m %p' },
      },
    },

    tabline = {
      lualine_b = {
        {
          'tabs',
          -- mode = 1,
          cond = function()
            return #vim.api.nvim_list_tabpages() > 1
          end,
          tabs_color = {
            active = 'TabLineSel',
            inactive = 'TabLine',
          },
          symbols = {
            modified = '●',
            alternate_file = '#',
            directory = '',
            readonly = '',
            unnamed = '[No Name]',
            newfile = '[New]',
          },
        },
      },
    },
  })
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = on_attach,
}
