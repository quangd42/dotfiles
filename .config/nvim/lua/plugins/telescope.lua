return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        sorting_strategy = "ascending",
        layout_config = {
          prompt_position = "top",
        },
      },
    },
    keys = {
      { "<leader>f", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      { "<leader><space>", false },
      { "<leader>fb", false },
      { "<leader>fc", false },
      { "<leader>ff", false },
      { "<leader>fF", false },
      { "<leader>fg", false },
      { "<leader>fr", false },
      { "<leader>fR", false },
    },
  },
}
