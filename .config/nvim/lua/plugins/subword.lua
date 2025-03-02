return {
  -- motions
  {
    'chrisgrieser/nvim-spider',
    opts = {
      skipInsignificantPunctuation = false,
    },
    keys = {
      { 'w', "<cmd>lua require('spider').motion('w')<CR>", mode = { 'n', 'o', 'x' } },
      { 'e', "<cmd>lua require('spider').motion('e')<CR>", mode = { 'n', 'o', 'x' } },
      { 'b', "<cmd>lua require('spider').motion('b')<CR>", mode = { 'n', 'o', 'x' } },
    },
  },

  -- textobjs
  {
    'chrisgrieser/nvim-various-textobjs',
    keys = {
      { 'ie', '<cmd>lua require("various-textobjs").subword("inner")<cr>', mode = { 'o', 'x' }, desc = 'inner subword' },
      { 'ae', '<cmd>lua require("various-textobjs").subword("outer")<cr>', mode = { 'o', 'x' }, desc = 'outer subword' },
    },
  },
}
