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
          h = {
            name = "+language Helpers",
            t = {
              name = "+GoTag",
              a = {
                function()
                  vim.api.nvim_feedkeys(":GoTagAdd ", "n", false)
                end,
                "GoTagAdd",
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
