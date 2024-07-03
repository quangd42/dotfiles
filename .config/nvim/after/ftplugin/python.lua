if vim.g.vscode then
  return
end
local wk = require("which-key")
wk.add({
  ["<leader>cV"] = { "<cmd>VenvSelectCached<cr>", "Load Last Used Venv" },
})
