return {
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    enabled = true,
    config = function()
      local colorscheme = vim.api.nvim_get_var("colors_name")
      local colors, incline_normal, incline_normal_nc
      if colorscheme == "catppuccin-mocha" then
        colors = require("catppuccin.palettes").get_palette("mocha")
        incline_normal = { guibg = colors.rosewater, guifg = colors.crust }
        incline_normal_nc = { guifg = colors.rosewater, guibg = colors.crust }
      elseif colorscheme == "tokyonight" then
        colors = require("tokyonight.colors").setup({ style = "moon" })
        incline_normal = { guibg = colors.yellow, guifg = colors.black }
        incline_normal_nc = { guifg = colors.yellow, guibg = colors.black }
      end
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = incline_normal,
            InclineNormalNC = incline_normal_nc,
          },
        },
        window = { margin = { vertical = 0, horizontal = 0 } },
        render = function(props)
          -- local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":~:.")
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          -- local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          -- return { { icon, guifg = color }, { " " }, { filename } }
          return { { filename } }
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
        -- separator_style = "slant",
      },
    },
  },
}
