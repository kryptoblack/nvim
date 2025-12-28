local lualine = require('lualine')

lualine.setup({
  options = {
    icons_enabled = true,
    globalstatus = true,
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
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

    tabline = {
      lualine_a = {
        'tabs',
        path = '0',
        mode = '1',

        tab_max_length = '40',
        max_length = '' .. vim.o.columns / 3,

        show_modified_status = 'true',
        symbols = {
          modified = { '●' },
          alternate_file = { '#' },
          directory = { '' },
          readonly = { '' },
          unnamed = { '[No Name]' },
          newfile = { '[New]' },
        },
        fmt = function(name, context)
          local buflist = vim.fn.tabpagebuflist(context.tabnr)
          local winnr = vim.fn.tabpagewinnr(context.tabnr)
          local bufnr = buflist[winnr]
          local mod = vim.fn.getbufvar(bufnr, '&mod')

          return name .. (mod == 1 and ' +' or '')
        end,
      },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
  },
})
