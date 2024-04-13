return {
  {
    "echasnovski/mini.files",
    opts = {
      mappings = {
        go_in = "L",
        go_in_plus = "l",
        go_out = "H",
        go_out_plus = "h",
      },
      options = {
        -- Whether to use for editing directories
        -- Disabled by default in LazyVim because neo-tree is used for that
        use_as_default_explorer = true,
      },
    },
  },
}
