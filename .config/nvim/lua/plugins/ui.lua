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
    config = function()
      require('focus').setup {
        commands = true,
        ui = {
          cursorline = false,
          signcolumn = false,
        },
      }
      local ignore_filetypes = { 'snacks_picker', 'dapui' }
      local ignore_buftypes = { 'nofile', 'prompt', 'popup' }

      local augroup = vim.api.nvim_create_augroup('FocusDisable', { clear = true })

      vim.api.nvim_create_autocmd('WinEnter', {
        group = augroup,
        callback = function(_)
          if vim.tbl_contains(ignore_buftypes, vim.bo.buftype) then
            vim.w.focus_disable = true
          else
            vim.w.focus_disable = false
          end
        end,
        desc = 'Disable focus autoresize for BufType',
      })

      vim.api.nvim_create_autocmd('FileType', {
        group = augroup,
        callback = function(_)
          if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
            vim.b.focus_disable = true
          else
            vim.b.focus_disable = false
          end
        end,
        desc = 'Disable focus autoresize for FileType',
      })
    end,
    keys = {
      { '<leader>uW', '<cmd>FocusToggle<cr>', desc = 'Toggle Window Focus' },
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
