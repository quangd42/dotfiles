local cmp = require("cmp")
local M = {}

---@param increment boolean
---@param g? boolean
function M.dial(increment, g)
  local mode = vim.fn.mode(true)
  -- Use visual commands for VISUAL 'v', VISUAL LINE 'V' and VISUAL BLOCK '\22'
  local is_visual = mode == "v" or mode == "V" or mode == "\22"
  local func = (increment and "inc" or "dec") .. (g and "_g" or "_") .. (is_visual and "visual" or "normal")
  local group = vim.g.dials_by_ft[vim.bo.filetype] or "default"
  return require("dial.map")[func](group)
end

return {
  -- Dials
  {
    "monaqa/dial.nvim",
    -- stylua: ignore
    keys = {
      { "<C-a>", false, expr = true, desc = "Increment", mode = {"n", "v"} },
      { "<C-'>", function() return M.dial(true) end, expr = true, desc = "Increment", mode = {"n", "v"} },
      { "g<C-a>", false, expr = true, desc = "Increment", mode = {"n", "v"} },
      { "g<C-'>", function() return M.dial(true, true) end, expr = true, desc = "Increment", mode = {"n", "v"} },
    },
  },
  -- LSP and cmp
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable a keymap
      keys[#keys + 1] = { "<c-k>", false }
      keys[#keys + 1] = { "K", false }
      -- add a keymap
      keys[#keys + 1] =
        { "<c-a>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" }
      keys[#keys + 1] = { "A", vim.lsp.buf.hover, desc = "Hover" }
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = {
      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = {},
        ["<C-y>"] = LazyVim.cmp.confirm(),
        ["<C-e>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
    },
  },
  -- Text Objects
  {
    "echasnovski/mini.ai",
    enabled = true,
    event = "VeryLazy",
    opts = {
      mappings = {
        -- Main textobject prefixes
        around = "'",
        inside = "i",

        -- Next/last variants
        around_next = "'n",
        inside_next = "in",
        around_last = "'l",
        inside_last = "il",
      },
    },
  },
  {
    "echasnovski/mini.indentscope",
    opts = {
      mappings = {
        -- Textobjects
        object_scope = "ii",
        object_scope_with_border = "'i",

        -- Motions (jump to respective border line; if not present - body line)
        goto_top = "[i",
        goto_bottom = "]i",
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      presets = "helix",
      plugins = {
        marks = false,
        registers = false,
        presets = { operators = false, motions = false, text_objects = false },
      },
    },
  },
  -- Motions
  -- See nvim-spider and smart-splits
}
