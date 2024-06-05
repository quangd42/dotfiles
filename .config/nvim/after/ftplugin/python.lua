local wk = require("which-key")
wk.register({
  ["<leader>c"] = {
    V = { "<cmd>VenvSelectCached<cr>", "Load Last Used Venv" },
  },
})
