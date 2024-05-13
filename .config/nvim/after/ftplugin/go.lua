local wk = require("which-key")
wk.register({
  ["<leader>"] = {
    l = {
      name = "+language action",
      t = {
        name = "+GoTag",
        a = {
          "<cmd>GoTagAdd json<cr>",
          "GoTagAdd json",
        },
        A = {
          function()
            vim.api.nvim_feedkeys(":GoTagAdd ", "n", false)
          end,
          "GoTagAdd prompt",
        },
        r = { "<cmd>GoTagRm<cr>", "GoTagRm" },
      },
      e = {
        { "<cmd>GoIfErr<cr>", "GoIfErr" },
      },
    },
  },
})
