return {
  {
    'folke/tokyonight.nvim',
    enabled = true,
    -- version = '4.11.0',
    commit = 'c8ea87c',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.cmd.colorscheme 'tokyonight-night'
    end,
    opts = {
      transparent = false,
      on_highlights = function(hl, colors)
        hl['SnacksDashboardHeader'] = {
          fg = colors.blue2,
        }
      end,
    },
  },
  {
    'rebelot/kanagawa.nvim',
    enabled = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'kanagawa'
    end,
    opts = {
      compile = true,
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = 'none',
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          -- Flash
          FlashLabel = { bg = colors.palette.samuraiRed },
          -- Dark completion menu
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
        }
      end,
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
