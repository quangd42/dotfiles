return {
  -- Improve vim.ui interfaces
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  -- Status line
  {
    'windwp/windline.nvim',
    event = 'VeryLazy',
    config = function()
      require 'wlsample.airline'
    end,
  },

  -- Indent line
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'VeryLazy',
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
    event = 'VeryLazy',
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
}
