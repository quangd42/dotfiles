return {
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    vscode = true,
    ---@type Flash.Config
    opts = {
      modes = { char = { highlight = { backdrop = false } } },
    },
    -- stylua: ignore
    keys = {
      { "<BS>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "<S-BS>", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    },
  },
}
