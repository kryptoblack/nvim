local lualine = require('lualine')

lualine.setup({
  options = {
    icons_enabled = true,
    theme = 'auto',
    globalstatus = true,
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
    },
    lualine_y = {
      {
        'searchcount',
        maxcount = 999,
        timeout = 500,
      },
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
})
