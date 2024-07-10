local find_files_no_ignore = function()
  local action_state = require("telescope.actions.state")
  local line = action_state.get_current_line()
  LazyVim.pick("find_files", { no_ignore = true, default_text = line })()
end
local find_files_with_hidden = function()
  local action_state = require("telescope.actions.state")
  local line = action_state.get_current_line()
  LazyVim.pick("find_files", { hidden = true, default_text = line })()
end
return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        sorting_strategy = "ascending",
        layout_config = {
          prompt_position = "top",
        },
        mappings = {
          i = {
            ["<c-i>"] = find_files_no_ignore,
            ["<c-h>"] = find_files_with_hidden,
          },
        },
      },
    },
    keys = {
      { "<leader>f", LazyVim.pick("auto"), desc = "Find Files (Root Dir)" },
      { "<leader>F", LazyVim.pick("auto", { root = false }), desc = "Find Files (cwd)" },
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
