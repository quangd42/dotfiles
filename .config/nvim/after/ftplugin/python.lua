if vim.g.vscode then
  return
end
local wk = require("which-key")
wk.add({
  { "<leader>cV", "<cmd>VenvSelectCached<cr>", desc = "Load Last Used Venv" },
})
