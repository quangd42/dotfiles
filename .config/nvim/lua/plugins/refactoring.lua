return {
  {
    'ThePrimeagen/refactoring.nvim',
    cmd = 'Refactor',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    keys = {
      { '<leader>r', '', desc = '+refactor', mode = { 'n', 'v' } },
      {
        '<leader>rs',
        function()
          require('refactoring').select_refactor {}
        end,
        mode = 'v',
        desc = 'Refactor',
      },
      {
        '<leader>ri',
        function()
          require('refactoring').refactor 'Inline Variable'
        end,
        mode = { 'n', 'v' },
        desc = 'Inline Variable',
      },
      {
        '<leader>rb',
        function()
          require('refactoring').refactor 'Extract Block'
        end,
        desc = 'Extract Block',
      },
      {
        '<leader>rB',
        function()
          require('refactoring').refactor 'Extract Block To File'
        end,
        desc = 'Extract Block To File',
      },
      {
        '<leader>rP',
        function()
          require('refactoring').debug.printf { below = false }
        end,
        desc = 'Debug Print',
      },
      {
        '<leader>rp',
        function()
          require('refactoring').debug.print_var { normal = true }
        end,
        desc = 'Debug Print Variable',
      },
      {
        '<leader>rc',
        function()
          require('refactoring').debug.cleanup {}
        end,
        desc = 'Debug Cleanup',
      },
      {
        '<leader>rf',
        function()
          require('refactoring').refactor 'Extract Function'
        end,
        mode = 'x',
        desc = 'Extract Function',
      },
      {
        '<leader>rF',
        function()
          require('refactoring').refactor 'Extract Function To File'
        end,
        mode = 'x',
        desc = 'Extract Function To File',
      },
      {
        '<leader>rx',
        function()
          require('refactoring').refactor 'Extract Variable'
        end,
        mode = 'x',
        desc = 'Extract Variable',
      },
    },
    opts = {
      prompt_func_return_type = {
        go = true,
      },
      prompt_func_param_type = {
        go = true,
      },
      printf_statements = {},
      print_var_statements = {},
      show_success_message = true, -- shows a message with information about the refactor on success
    },
  },
}
