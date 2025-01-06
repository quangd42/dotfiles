-- Collection of various small independent plugins/modules
return {
  -- Better text-objects
  {
    'echasnovski/mini.ai',
    event = 'VeryLazy',
    opts = function()
      local ai = require 'mini.ai'
      -- taken from MiniExtra.gen_ai_spec.buffer
      local function ai_buffer(ai_type)
        local start_line, end_line = 1, vim.fn.line '$'
        if ai_type == 'i' then
          -- Skip first and last blank lines for `i` textobject
          local first_nonblank, last_nonblank = vim.fn.nextnonblank(start_line), vim.fn.prevnonblank(end_line)
          -- Do nothing for buffer with all blanks
          if first_nonblank == 0 or last_nonblank == 0 then
            return { from = { line = start_line, col = 1 } }
          end
          start_line, end_line = first_nonblank, last_nonblank
        end

        local to_col = math.max(vim.fn.getline(end_line):len(), 1)
        return { from = { line = start_line, col = 1 }, to = { line = end_line, col = to_col } }
      end
      local function ai_line(ai_type)
        local line_num = vim.fn.line '.'
        local line = vim.fn.getline(line_num)
        -- Ignore indentation for `i` textobject
        local from_col = ai_type == 'a' and 1 or (line:match('^(%s*)'):len() + 1)
        -- Don't select `\n` past the line to operate within a line
        local to_col = line:len()

        return { from = { line = line_num, col = from_col }, to = { line = line_num, col = to_col } }
      end

      return {
        n_lines = 500,
        custom_textobjects = {
          f = ai.gen_spec.treesitter { a = '@function.outer', i = '@function.inner' }, -- function
          -- c = ai.gen_spec.treesitter { a = '@class.outer', i = '@class.inner' }, -- class
          T = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' }, -- tags
          -- e = { -- Word with case
          --   { '%u[%l%d]+%f[^%l%d]', '%f[%S][%l%d]+%f[^%l%d]', '%f[%P][%l%d]+%f[^%l%d]', '^[%l%d]+%f[^%l%d]' },
          --   '^().*()$',
          -- },
          y = ai_line, -- line
          g = ai_buffer, -- buffer
          F = ai.gen_spec.function_call(), -- u for "Usage"
        },
      }
    end,
  },

  -- indentscope
  {
    'echasnovski/mini.indentscope',
    version = false, -- wait till new 0.7.0 release to put it back on semver
    -- event = 'VeryLazy',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      symbol = '│',
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = {
          'Trouble',
          'alpha',
          'dashboard',
          'fzf',
          'help',
          'lazy',
          'mason',
          'neo-tree',
          'notify',
          'snacks_dashboard',
          'snacks_notif',
          'snacks_terminal',
          'snacks_win',
          'toggleterm',
          'trouble',
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })

      vim.api.nvim_create_autocmd('User', {
        pattern = 'SnacksDashboardOpened',
        callback = function(data)
          vim.b[data.buf].miniindentscope_disable = true
        end,
      })
    end,
  },

  -- move
  {
    'echasnovski/mini.move',
    event = 'VeryLazy',
    opts = {
      mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = '<M-left>',
        right = '<M-right>',
        down = '<M-down>',
        up = '<M-up>',

        -- Move current line in Normal mode
        line_left = '<M-left>',
        line_right = '<M-right>',
        line_down = '<M-down>',
        line_up = '<M-up>',
      },
    },
  },

  -- auto pairs
  {
    'echasnovski/mini.pairs',
    event = 'VeryLazy',
    opts = {
      modes = { insert = true, command = true, terminal = false },
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = { 'string' },
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
      mappings = {
        ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\][%s%"\'`%)}%]]' },
        ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\][%s%"\'`%)}%]]' },
        ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\][%s%"\'`%)}%]]' },
        ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\"].', register = { cr = false } },
        ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = "[^%a\\'].", register = { cr = false } },
        ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\`].', register = { cr = false } },
      },
    },
  },

  -- surround
  {
    'echasnovski/mini.surround',
    event = 'VeryLazy',
    opts = {
      mappings = {
        add = 'gsa', -- Add surrounding in Normal and Visual modes
        delete = 'gsd', -- Delete surrounding
        find = 'gsf', -- Find surrounding (to the right)
        find_left = 'gsF', -- Find surrounding (to the left)
        highlight = 'gsh', -- Highlight surrounding
        replace = 'gsr', -- Replace surrounding
        update_n_lines = 'gsn', -- Update `n_lines`
      },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
