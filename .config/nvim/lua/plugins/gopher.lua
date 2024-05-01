return {
  {
    "olexsmir/gopher.nvim",
    event = "VeryLazy",
    ft = "go",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function(_, opts)
      require("gopher").setup(opts)
      local wk = require("which-key")
      wk.register({
        ["<leader>"] = {
          a = {
            name = "+action",
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
    end,
    build = function()
      vim.cmd([[silent! GoInstallDeps]])
    end,
  },
}
