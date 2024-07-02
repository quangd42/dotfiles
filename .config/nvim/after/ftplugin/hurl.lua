local wk = require("which-key")
wk.register({
  ["<leader>l"] = {
    name = "+language helpers",
    h = {
      name = "+hurl",
      a = {
        ":HurlRunner<cr>",
        "Run All Requests",
        mode = { "n", "v" },
      },
      r = {
        "<cmd>HurlRunnerAt<cr>",
        "Run Request at Cursor",
      },
      t = {
        "<cmd>HurlRunnerToEntry<cr>",
        "Run Requests to Cursor",
      },
      m = {
        "<cmd>HurlToggleMode<cr>",
        "Hurl Toggle View Mode",
      },
      l = {
        "<cmd>HurlShowLastResponse<cr>",
        "Show Last Response",
      },
      A = {
        "<cmd>HurlToggleMode<cr>",
        "Run All Requests in Verbose mode",
      },
      s = {
        function()
          vim.api.nvim_feedkeys(":HurlSetVariable ", "n", false)
        end,
        "Set Variable",
      },
      v = {
        "<cmd>HurlManageVariable<cr>",
        "Manage Variables",
      },
    },
  },
})
