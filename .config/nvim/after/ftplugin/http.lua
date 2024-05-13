local wk = require("which-key")
wk.register({
  ["<leader>"] = {
    l = {
      name = "+language action",
      r = {
        "<cmd>Rest run<cr>",
        "Run request under the cursor",
      },
      l = { "<cmd>Rest run last<cr>", "Re-run latest request" },
    },
  },
})
