return {
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    enabled = true,
    config = function()
      require("incline").setup({
        window = { margin = { vertical = 0, horizontal = 0 } },
        render = function(props)
          local devicons = require("nvim-web-devicons")
          local lzicons = LazyVim.config.icons
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if filename == "" then
            filename = "[No Name]"
          end
          local ft_icon, ft_color = devicons.get_icon_color(filename)
          local modified = vim.bo[props.buf].modified
          local colors = require("tokyonight.colors").setup({ style = "moon" })

          local function get_git_diff()
            local icons = {
              removed = lzicons.git.removed,
              changed = lzicons.git.modified,
              added = lzicons.git.added,
            }
            local signs = vim.b[props.buf].gitsigns_status_dict
            local labels = {}
            if signs == nil then
              return labels
            end
            for name, icon in pairs(icons) do
              if tonumber(signs[name]) and signs[name] > 0 then
                table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
              end
            end
            if #labels > 0 then
              table.insert(labels, { "┊ " })
            end
            return labels
          end

          local function get_diagnostic_label()
            local icons = {
              error = lzicons.diagnostics.Error,
              warn = lzicons.diagnostics.Warn,
              info = lzicons.diagnostics.Info,
              hint = lzicons.diagnostics.Hint,
            }
            local label = {}

            for severity, icon in pairs(icons) do
              local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
              if n > 0 then
                table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
              end
            end
            if #label > 0 then
              table.insert(label, { "┊ " })
            end
            return label
          end

          return {
            { get_diagnostic_label() },
            { get_git_diff() },
            { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
            { filename },
            { modified and " ●" or "", guifg = colors.yellow },
          }
        end,
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    enabled = true,
    opts = {
      options = {
        right_mouse_command = false,
        middle_mouse_command = "bdelete! %d",
        -- separator_style = "slant",
      },
    },
  },
}
