return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    -- branch = '0.1.x',
    version = false, -- NOTE: use HEAD so that fuzzy finding ignore space
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      {
        'debugloop/telescope-undo.nvim',
        keys = {
          {
            '<leader>su',
            '<cmd>Telescope undo<cr>',
            desc = 'Undo History',
          },
        },
      },
      {
        'piersolenski/telescope-import.nvim',
        keys = {
          {
            '<leader>si',
            '<cmd>Telescope import<cr>',
            desc = 'Workspace Import Statements',
          },
        },
      },
      { 'nvim-tree/nvim-web-devicons' },
    },
    config = function()
      local actions = require 'telescope.actions'
      require('telescope').setup {
        defaults = {
          prompt_prefix = ' ',
          selection_caret = ' ',
          layout_config = {
            horizontal = {
              preview_width = 0.6,
            },
          },
          file_ignore_patterns = {
            'node_modules/*',
          },

          mappings = {
            i = {
              ['<C-Down>'] = actions.cycle_history_next,
              ['<C-Up>'] = actions.cycle_history_prev,
              ['<C-f>'] = actions.preview_scrolling_down,
              ['<C-b>'] = actions.preview_scrolling_up,
              ['<C-s>'] = actions.select_horizontal,
              ['<C-x>'] = false,
              ['<esc>'] = actions.close,
            },
            n = {
              ['q'] = actions.close,
            },
          },
        },

        pickers = {
          find_files = {
            hidden = true,
          },
          git_files = {
            hidden = true,
          },
        },

        extensions = {
          undo = {
            -- side_by_side = true,
            layout_strategy = 'vertical',
            layout_config = {
              preview_height = 0.7,
              preview_cutoff = 20,
            },
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')

      local builtin = require 'telescope.builtin'
      local map = vim.keymap.set

      map('n', '<leader>f', builtin.find_files, { desc = 'Find Files' })
      map('n', '<leader>F', function()
        builtin.find_files { no_ignore = true, hidden = true }
      end, { desc = 'Find All Files' })
      map('n', '<leader>b', function()
        builtin.buffers { sort_mru = true, sort_lastused = true, ignore_current_buffer = true }
      end, { desc = 'Buffers' })

      map('n', '<leader>s"', builtin.registers, { desc = 'Registers' })
      map('n', '<leader>sa', builtin.autocommands, { desc = 'AutoCommands' })
      map('n', '<leader>sb', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = 'Fuzzily Search in Current Buffer' })
      map('n', '<leader>sc', builtin.command_history, { desc = 'Command History' })
      map('n', '<leader>sC', builtin.commands, { desc = 'Commands' })
      map('n', '<leader>sd', function()
        builtin.diagnostics { bufnr = 0 }
      end, { desc = 'Document Diagnostics' })
      map('n', '<leader>sD', builtin.diagnostics, { desc = 'Workspace Diagnostics' })
      map('n', '<leader>sg', builtin.git_files, { desc = 'Find Git Files' })
      map('n', '<leader>sG', function()
        builtin.live_grep { grep_open_files = true }
      end, { desc = 'Live Grep (Open Files)' })
      map('n', '<leader>sh', builtin.help_tags, { desc = 'Help Pages' })
      map('n', '<leader>sj', builtin.jumplist, { desc = 'Jumplist' })
      map('n', '<leader>sk', builtin.keymaps, { desc = 'Keymaps' })
      map('n', '<leader>sl', builtin.loclist, { desc = 'Location List' })
      map('n', '<leader>sm', builtin.marks, { desc = 'Jump to Mark' })
      map('n', '<leader>sr', builtin.resume, { desc = 'Resume' })
      map('n', '<leader>sp', builtin.builtin, { desc = 'Select Builtin Pickers' })
      map('n', '<leader>sq', builtin.quickfix, { desc = 'Quickfix List' })
      map({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = 'Current Word' })
      map('n', '<leader>s.', builtin.oldfiles, { desc = 'Recent Files' })
      map('n', '<leader>uC', function()
        builtin.colorscheme { enable_preview = true }
      end, { desc = 'Colorscheme with Preview' })
      map('n', '<leader>/', builtin.live_grep, { desc = 'Live Grep' })
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et
