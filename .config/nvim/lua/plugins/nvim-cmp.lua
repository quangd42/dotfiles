local cmp = require("cmp")
return {
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    opts = {
      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = {},
        ["<C-y>"] = LazyVim.cmp.confirm(),
        ["<C-e>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-m>"] = LazyVim.cmp.confirm(), -- for qwerty layout
        ["<Tab>"] = {},
        ["<C-Right>"] = function(fallback)
          return LazyVim.cmp.map({ "snippet_forward" }, fallback)()
        end,
      }),
    },
  },
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    dependencies = {
      "chrisgrieser/cmp_yanky",
    },
    opts = {
      sources = {
        -- default values
        {
          name = "cmp_yanky",
          option = {
            -- only suggest items which match the current filetype
            onlyCurrentFiletype = false,
            -- only suggest items with a minimum length
            minLength = 3,
          },
        },
      },
    },
  },
}
