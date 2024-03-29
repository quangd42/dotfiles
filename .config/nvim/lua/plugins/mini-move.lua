return {
  {
    "echasnovski/mini.move",
    event = "VeryLazy",
    config = function(_, opts)
      vim.schedule(function()
        require("mini.move").setup(opts)
      end)
    end,
  },
}
