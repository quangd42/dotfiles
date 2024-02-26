return {
  { "echasnovski/mini.move", version = "*" },
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false,
    opts = {},
    keys = {
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
      { "<leader>bsh", "<cmd>:lua require('smart-splits').swap_buf_left()<cr>", desc = "Swap buffer left" },
      { "<leader>bsj", "<cmd>:lua require('smart-splits').swap_buf_down()<cr>", desc = "Swap buffer down" },
      { "<leader>bsk", "<cmd>:lua require('smart-splits').swap_buf_up()<cr>", desc = "Swap buffer up" },
      { "<leader>bsl", "<cmd>:lua require('smart-splits').swap_buf_right()<cr>", desc = "Swap buffer right" },
    },
  },
}
