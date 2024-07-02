return {
  {
    "jellydn/hurl.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = "hurl",
    opts = {
      -- Show debugging info
      debug = false,
      -- Show notification on run
      show_notification = false,
      -- Show response in popup or split
      mode = "popup",
      -- Popup settings
      popup_position = "50%",
      popup_size = {
        width = 70,
        height = 40,
      },
      -- Default formatter
      formatters = {
        json = { "jq" }, -- Make sure you have install jq in your system, e.g: brew install jq
        html = {
          "prettier", -- Make sure you have install prettier in your system, e.g: npm install -g prettier
          "--parser",
          "html",
        },
      },
    },
    -- keys = {
    --   -- Run API request
    --   { "<leader>lha", "<cmd>HurlRunner<CR>", desc = "Run All requests" },
    --   { "<leader>lhr", "<cmd>HurlRunnerAt<CR>", desc = "Run Api request" },
    --   { "<leader>lht", "<cmd>HurlRunnerToEntry<CR>", desc = "Run Api request to entry" },
    --   { "<leader>lhm", "<cmd>HurlToggleMode<CR>", desc = "Hurl Toggle Mode" },
    --   { "<leader>lhv", "<cmd>HurlVerbose<CR>", desc = "Run Api in verbose mode" },
    --   -- Run Hurl request in visual mode
    --   { "<leader>lha", ":HurlRunner<CR>", desc = "Hurl Runner", mode = "v" },
    -- },
  },
}
