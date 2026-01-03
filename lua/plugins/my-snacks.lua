local header = [[
██╗   ██╗███████╗ ██████╗ ██████╗ ██████╗ ███████╗
██║   ██║██╔════╝██╔════╝██╔═══██╗██╔══██╗██╔════╝
██║   ██║███████╗██║     ██║   ██║██║  ██║█████╗  
╚██╗ ██╔╝╚════██║██║     ██║   ██║██║  ██║██╔══╝  
 ╚████╔╝ ███████║╚██████╗╚██████╔╝██████╔╝███████╗
  ╚═══╝  ╚══════╝ ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝]]

local keys = {
  {
    icon = ' ',
    key = 'f',
    desc = 'Find File',
    action = ":lua Snacks.dashboard.pick('files')",
  },
  {
    icon = ' ',
    key = 'n',
    desc = 'New File',
    action = ':ene | startinsert',
  },
  {
    icon = ' ',
    key = 'g',
    desc = 'Find Text',
    action = ":lua Snacks.dashboard.pick('live_grep')",
  },
  {
    icon = ' ',
    key = 'r',
    desc = 'Recent Files',
    action = ":lua Snacks.dashboard.pick('oldfiles')",
  },
  {
    icon = ' ',
    key = 'c',
    desc = 'Config',
    action = function()
      require('utils.tmux-sessionizer').open(vim.fn.stdpath('config'))
    end,
  },
  {
    icon = ' ',
    key = 's',
    desc = 'Restore Session',
    section = 'session',
  },
  {
    icon = '󰒲 ',
    key = 'L',
    desc = 'Lazy',
    action = ':Lazy',
    enabled = package.loaded.lazy ~= nil,
  },
  { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
}

local function on_attach()
  local snacks = require('snacks')
  snacks.setup({
    dashboard = {
      enabled = true,
      -- pane_gap = 4,
      preset = {
        pick = nil,
        header = header,
        keys = keys,
      },

      sections = {
        {
          pane = 1,

          { section = 'header', padding = { 0, 1 } },

          {
            icon = ' ',
            title = 'Keymaps',
            section = 'keys',
            indent = 2,
            padding = 1,
          },

          function(_)
            return {
              icon = ' ',
              title = 'Projects',
              section = 'projects',
              indent = 2,
              padding = 1,
              limit = 5,
              key = 'o',
              action = function(value)
                if type(value) == 'string' then
                  require('utils.tmux-sessionizer').open(value)
                else
                  require('utils.tmux-sessionizer').open()
                end
              end,
              pick = false,
            }
          end,
        },

        -- FIXME: panes are not working
        {
          pane = 2,
          {
            icon = ' ',
            desc = 'Browse Repo',
            padding = 1,
            key = 'b',
            action = function()
              snacks.gitbrowse()
            end,
          },
          --   function()
          --     local in_git = snacks.git.get_root() ~= nil
          --     local cmds = {
          --       {
          --         title = 'Notifications',
          --         cmd = 'gh notify -s -a -n5',
          --         action = function()
          --           vim.ui.open('https://github.com/notifications')
          --         end,
          --         key = 'n',
          --         icon = ' ',
          --         height = 5,
          --         enabled = true,
          --       },
          --       {
          --         title = 'Open Issues',
          --         cmd = 'gh issue list -L 3',
          --         key = 'i',
          --         action = function()
          --           vim.fn.jobstart('gh issue list --web', { detach = true })
          --         end,
          --         icon = ' ',
          --         height = 7,
          --       },
          --       {
          --         icon = ' ',
          --         title = 'Open PRs',
          --         cmd = 'gh pr list -L 3',
          --         key = 'P',
          --         action = function()
          --           vim.fn.jobstart('gh pr list --web', { detach = true })
          --         end,
          --         height = 7,
          --       },
          --       {
          --         icon = ' ',
          --         title = 'Git Status',
          --         cmd = 'git --no-pager diff --stat -B -M -C',
          --         height = 10,
          --       },
          --     }
          --     return vim.tbl_map(function(cmd)
          --       return vim.tbl_extend('force', {
          --         pane = 2,
          --         section = 'terminal',
          --         enabled = in_git,
          --         padding = 1,
          --         ttl = 5 * 60,
          --         indent = 3,
          --       }, cmd)
          --     end, cmds)
          --   end,

          { section = 'startup' },
        },
      },
    },
    picker = {
      enabled = true,
      layout = {
        preset = 'ivy',
      },
    },
  })
end

return {
  'folke/snacks.nvim',
  config = on_attach,
  priority = 1000,
  lazy = false,
}
