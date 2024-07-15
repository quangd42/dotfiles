local cmp = require("cmp")
return {
  {
    "hrsh7th/nvim-cmp",
    opts = {
      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = {},
        ["<C-m>"] = LazyVim.cmp.confirm(),
        ["<C-l>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
    },
  },
}
