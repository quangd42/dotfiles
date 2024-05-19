return {
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          jump_labels = true,
          config = function(opts)
            opts.jump_labels = opts.jump_labels
              and vim.v.count == 0
              and vim.fn.reg_executing() == ""
              and vim.fn.reg_recording() == ""
              -- Show jump labels only when not in operator-pending mode
              and not vim.fn.mode(true):find("o")
          end,
        },
        search = {
          enabled = true,
        },
      },
      jump = {
        autojump = true,
      },
    },
  },
}
