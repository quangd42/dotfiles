local cmp = require("cmp")
return {
  {
    "hrsh7th/nvim-cmp",
    opts = {
      mapping = cmp.mapping.preset.insert({
        -- ["<C-y>"] = function(fallback)
        --   if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
        --     LazyVim.create_undo()
        --     if cmp.confirm({ select = true }) then
        --       return
        --     end
        --   end
        --   return fallback()
        -- end,
        -- ["<C-a>"] = function(fallback)
        --   if cmp.core.view:visible() or vim.fn.pumvisible() == 1 then
        --     LazyVim.create_undo()
        --     if
        --       cmp.confirm({
        --         behavior = cmp.ConfirmBehavior.Replace,
        --         select = true,
        --       })
        --     then
        --       return
        --     end
        --   end
        --   return fallback()
        -- end,
        ["<CR>"] = {},
        ["<C-y>"] = LazyVim.cmp.confirm(),
        ["<C-r>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
    },
  },
}
