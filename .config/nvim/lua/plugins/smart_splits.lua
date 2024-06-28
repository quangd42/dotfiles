local keys = {
  -- Move to Window using the <ctrl> hjkl keys
  { "<C-h>", "<cmd>:lua require('smart-splits').move_cursor_left()<cr>", desc = "Go to left window" },
  { "<C-j>", "<cmd>:lua require('smart-splits').move_cursor_down()<cr>", desc = "Go to lower window" },
  { "<C-k>", "<cmd>:lua require('smart-splits').move_cursor_up()<cr>", desc = "Go to upper window" },
  { "<C-l>", "<cmd>:lua require('smart-splits').move_cursor_right()<cr>", desc = "Go to right window" },
  -- Resizing window
  { "<C-Left>", "<cmd>:lua require('smart-splits').resize_left()<cr>", desc = "Go to left window" },
  { "<C-Down>", "<cmd>:lua require('smart-splits').resize_down()<cr>", desc = "Go to lower window" },
  { "<C-Up>", "<cmd>:lua require('smart-splits').resize_up()<cr>", desc = "Go to upper window" },
  { "<C-Right>", "<cmd>:lua require('smart-splits').resize_right()<cr>", desc = "Go to right window" },
  -- swapping buffers between windows
  { "<leader>wh", "<cmd>:lua require('smart-splits').swap_buf_left()<cr>", desc = "Swap buffer left" },
  { "<leader>wj", "<cmd>:lua require('smart-splits').swap_buf_down()<cr>", desc = "Swap buffer down" },
  { "<leader>wk", "<cmd>:lua require('smart-splits').swap_buf_up()<cr>", desc = "Swap buffer up" },
  { "<leader>wl", "<cmd>:lua require('smart-splits').swap_buf_right()<cr>", desc = "Swap buffer right" },
}

if vim.g.langmap ~= "" then
  keys = {
    -- Move to Window using the <ctrl> hjkl keys
    { "<C-p>", "<cmd>:lua require('smart-splits').move_cursor_left()<cr>", desc = "Go to left window" },
    { "<C-h>", "<cmd>:lua require('smart-splits').move_cursor_down()<cr>", desc = "Go to lower window" },
    { "<C-a>", "<cmd>:lua require('smart-splits').move_cursor_up()<cr>", desc = "Go to upper window" },
    { "<C-e>", "<cmd>:lua require('smart-splits').move_cursor_right()<cr>", desc = "Go to right window" },
    -- Resizing window
    { "<C-Left>", "<cmd>:lua require('smart-splits').resize_left()<cr>", desc = "Go to left window" },
    { "<C-Down>", "<cmd>:lua require('smart-splits').resize_down()<cr>", desc = "Go to lower window" },
    { "<C-Up>", "<cmd>:lua require('smart-splits').resize_up()<cr>", desc = "Go to upper window" },
    { "<C-Right>", "<cmd>:lua require('smart-splits').resize_right()<cr>", desc = "Go to right window" },
    -- swapping buffers between windows
    { "<leader>wp", "<cmd>:lua require('smart-splits').swap_buf_left()<cr>", desc = "Swap buffer left" },
    { "<leader>wh", "<cmd>:lua require('smart-splits').swap_buf_down()<cr>", desc = "Swap buffer down" },
    { "<leader>wa", "<cmd>:lua require('smart-splits').swap_buf_up()<cr>", desc = "Swap buffer up" },
    { "<leader>we", "<cmd>:lua require('smart-splits').swap_buf_right()<cr>", desc = "Swap buffer right" },
  }
end

return {
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    opts = {
      at_edge = "stop",
    },
    keys = keys,
  },
}
