return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        zls = {},
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        zig = { 'zigfmt' },
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'zig' } },
  },
}
