return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  events = "InsertEnter",
  opts = {
    suggestion = {
      keymap = {
        accept = "<M-y>",
        accept_word = "<M-w>",
        accept_line = "<M-l>",
        next = "<M-n>",
        prev = "<M-p>",
        dismiss = "<M-Esc>",
      },
    },
  },
  -- keys = {
  --   { "<leader>ct", ":Copilot suggestion toggle_auto_trigger<cr>", desc = "Toggle Copilot AutoTrigger" },
  -- },
}
