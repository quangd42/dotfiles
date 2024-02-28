return {
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    enabled = true,
    config = function()
      local colors = require("tokyonight.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = colors.magenta, guifg = colors.black },
            InclineNormalNC = { guifg = colors.magenta, guibg = colors.black },
          },
        },
        window = { margin = { vertical = 0, horizontal = 0 } },
        render = function(props)
          -- local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":~:.")
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        right_mouse_command = false,
        middle_mouse_command = "bdelete! %d",
        separator_style = "slant",
      },
    },
  },
}
