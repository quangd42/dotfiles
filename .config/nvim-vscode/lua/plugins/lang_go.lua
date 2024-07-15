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
    end,
    build = function()
      vim.cmd([[silent! GoInstallDeps]])
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "templ",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        templ = {},
      },
      gopls = {
        settings = {
          gopls = {
            hints = {
              parameterNames = false,
              assignVariableTypes = false,
              compositeLiteralFields = false,
            },
            analyses = {
              fieldalignment = false,
            },
          },
        },
      },
    },
  },
}
