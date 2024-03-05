return {
  "linux-cultist/venv-selector.nvim",
  keys = {
    -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
    { "<leader>cV", "<cmd>VenvSelectCached<cr>", desc = "Load Last Used Venv" },
  },
}
