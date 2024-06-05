return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      gopls = {
        settings = {
          gopls = {
            hints = {
              parameterNames = false,
              assignVariableTypes = false,
            },
          },
        },
      },
    },
  },
}
