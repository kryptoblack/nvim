local config = {
  position = 'top-right',
  show_count = true,
  timeout = 1,
  maxkeys = 5,
}

-- FIXME: ShowkeysToggle not triggering via cmd
return {
  'nvzone/showkeys',
  cmd = 'ShowkeysToggle',
  opts = config,
}
