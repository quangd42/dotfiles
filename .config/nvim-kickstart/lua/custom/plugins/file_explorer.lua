return {
  'echasnovski/mini.files',
  version = '*',
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<leader>ft', '<cmd>:lua MiniFiles.open()<cr>', desc = 'Open mini.files' },
  },
  config = function()
    require('mini.files').setup()
  end,
}
