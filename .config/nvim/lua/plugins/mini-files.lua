return {
  {
    "echasnovski/mini.files",
    enabled = true,
    opts = {
      windows = {
        preview = true,
        width_focus = 45,
        width_preview = 45,
      },
      mappings = {
        go_in = "L",
        go_in_plus = "l",
        -- go_out = "H",
        -- go_out_plus = "h",
      },
      options = {
        -- Whether to use for editing directories
        -- Disabled by default in LazyVim because neo-tree is used for that
        use_as_default_explorer = true,
      },
    },
    keys = {
      { "<leader>fm", false },
      { "<leader>fM", false },
      {
        "<leader>e",
        function()
          if not MiniFiles.close() then
            MiniFiles.open(vim.api.nvim_buf_get_name(0), true)
          end
        end,
        desc = "Open mini.files (Directory of Current File)",
      },
    },
    config = function(_, opts)
      require("mini.files").setup(opts)

      local show_dotfiles = true
      local filter_show = function(fs_entry)
        return true
      end
      local filter_hide = function(fs_entry)
        return not vim.startswith(fs_entry.name, ".")
      end

      local toggle_dotfiles = function()
        show_dotfiles = not show_dotfiles
        local new_filter = show_dotfiles and filter_show or filter_hide
        require("mini.files").refresh({ content = { filter = new_filter } })
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id
          -- Tweak left-hand side of mapping to your liking
          vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id, desc = "Toggle Hidden Files" })
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesActionRename",
        callback = function(event)
          LazyVim.lsp.on_rename(event.data.from, event.data.to)
        end,
      })
    end,
  },
}
