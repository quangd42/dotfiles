return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },
  {
    "rest-nvim/rest.nvim",
    ft = "http",
    dependencies = { "luarocks.nvim" },
    config = function()
      require("rest-nvim").setup()
      local wk = require("which-key")
      wk.register({
        ["<leader>a"] = {
          r = {
            name = "+Rest",
            r = {
              "<cmd>Rest run<cr>",
              "Run request under the cursor",
            },
            l = { "<cmd>Rest run last<cr>", "Re-run latest request" },
          },
        },
      })
    end,
    -- keys = {
    --   {
    --     "<leader>arr",
    --     "<cmd>Rest run<cr>",
    --     desc = "Run request under the cursor",
    --   },
    --   {
    --     "<leader>arl",
    --     "<cmd>Rest run last<cr>",
    --     desc = "Re-run latest request",
    --   },
    -- },
  },
}
