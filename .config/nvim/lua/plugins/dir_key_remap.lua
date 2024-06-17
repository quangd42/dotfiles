local cmp = require("cmp")
local M = {}
---@type table<string, table<string, string[]>>
M.dials_by_ft = {}

---@param increment boolean
---@param g? boolean
function M.dial(increment, g)
  local mode = vim.fn.mode(true)
  -- Use visual commands for VISUAL 'v', VISUAL LINE 'V' and VISUAL BLOCK '\22'
  local is_visual = mode == "v" or mode == "V" or mode == "\22"
  local func = (increment and "inc" or "dec") .. (g and "_g" or "_") .. (is_visual and "visual" or "normal")
  local group = M.dials_by_ft[vim.bo.filetype] or "default"
  return require("dial.map")[func](group)
end

return {
  {
    "monaqa/dial.nvim",
    -- stylua: ignore
    keys = function ()
      return {
        { "<C-j>", function() return M.dial(true) end, expr = true, desc = "Increment", mode = {"n", "v"} },
        { "<C-x>", function() return M.dial(false) end, expr = true, desc = "Decrement", mode = {"n", "v"} },
        { "g<C-j>", function() return M.dial(true, true) end, expr = true, desc = "Increment", mode = {"n", "v"} },
        { "g<C-x>", function() return M.dial(false, true) end, expr = true, desc = "Decrement", mode = {"n", "v"} },
      }
    end,
  },
  {
    "gbprod/yanky.nvim",
    keys = function()
      return {
        {
          "<leader>k",
          function()
            local ok, telescope = pcall(require, "telescope")
            if ok then
              telescope.extensions.yank_history.yank_history({})
            else
              vim.cmd([[YankyRingHistory]])
            end
          end,
          desc = "Open Yank History",
        },
        -- stylua: ignore
        { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank Text" },
        { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put Yanked Text After Cursor" },
        { "p", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put Yanked Text Before Cursor" },
        { "gk", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put Yanked Text After Selection" },
        { "gK", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put Yanked Text Before Selection" },
        { "[y", "<Plug>(YankyCycleForward)", desc = "Cycle Forward Through Yank History" },
        { "]y", "<Plug>(YankyCycleBackward)", desc = "Cycle Backward Through Yank History" },
        { "]k", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put Indented After Cursor (Linewise)" },
        { "[k", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put Indented Before Cursor (Linewise)" },
        { "]K", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put Indented After Cursor (Linewise)" },
        { "[K", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put Indented Before Cursor (Linewise)" },
        { ">k", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and Indent Right" },
        { "<k", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and Indent Left" },
        { ">K", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put Before and Indent Right" },
        { "<K", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put Before and Indent Left" },
        { "=k", "<Plug>(YankyPutAfterFilter)", desc = "Put After Applying a Filter" },
        { "=K", "<Plug>(YankyPutBeforeFilter)", desc = "Put Before Applying a Filter" },
      }
    end,
  },
  -- LSP keymaps
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable a keymap
      keys[#keys + 1] = { "<c-k>", false }
      -- add a keymap
      keys[#keys + 1] =
        { "<c-a>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" }
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = {
      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = {},
        ["<C-y>"] = LazyVim.cmp.confirm(),
        ["<C-e>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-p>"] = {},
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      }),
    },
  },
}
