local ui_events = { 'BufReadPre', 'BufNewFile' }
return {

  -- Status line
  {
    'windwp/windline.nvim',
    event = ui_events,
    config = function()
      require 'wlsample.airline'
    end,
  },

  -- Indent line
  {
    'lukas-reineke/indent-blankline.nvim',
    event = ui_events,
    main = 'ibl',
    opts = {
      scope = { enabled = false },
      indent = { char = '·', tab_char = '│' },
      -- indent = { char = '│', tab_char = '│' }, -- from lazyvim
    },
  },

  -- Auto resize focused splits
  {
    'nvim-focus/focus.nvim',
    event = ui_events,
    opts = {
      commands = true,
      ui = {
        cursorline = false,
        signcolumn = false,
      },
    },
    keys = {
      { '<leader>uf', '<cmd>FocusToggle<cr>', desc = 'Toggle Window Focus' },
    },
  },

  -- smooth scrolling
  {
    'karb94/neoscroll.nvim',
    enabled = false,
    event = ui_events,
    opts = {
      duration_multiplier = 0.2,
    },
  },
}
