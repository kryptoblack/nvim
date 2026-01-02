local function on_attach()
  local smear_cursor = require('smear_cursor')
  smear_cursor.setup({
    smear_between_buffers = true,
    smear_between_neighbor_lines = true,
    scroll_buffer_space = true,
    legacy_computing_symbols_support = false,
    smear_insert_mode = true,
    cursor_color = '#ebbcba', -- https://rosepinetheme.com/palette/ (Rose Main)

    stiffness = 0.8,
    trailing_stiffness = 0.6,
    stiffness_insert_mode = 0.7,
    trailing_stiffness_insert_mode = 0.7,
    damping = 0.95,
    damping_insert_mode = 0.95,
    distance_stop_animating = 0.5,
    time_interval = 2,
  })
end

return {
  'sphamba/smear-cursor.nvim',
  event = 'VeryLazy',
  config = on_attach,
}
