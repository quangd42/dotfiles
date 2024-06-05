return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- SQL
        sql = { { "sqlfluff", "sql_format" } },
      },
      formatters = {
        sql_formatter = {
          prepend_args = function()
            local filename = "sql_formatter.json"
            if io.open(filename, "r") then
              return { "--config", filename }
            else
              vim.notify("sql_formatter.json not found in project directory", vim.log.levels.WARN, {
                title = "Conform.nvim",
              })
              return
            end
          end,
        },
        sqlfluff = {
          args = { "format", "-" },
        },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "sqlfluff" })
    end,
  },
}
