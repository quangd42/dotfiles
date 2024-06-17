-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.scrolloff = 10 -- Lines of context
vim.opt.inccommand = "split"

local function escape(str)
  -- You need to escape these characters to work correctly
  local escape_chars = [[;,."|\]]
  return vim.fn.escape(str, escape_chars)
end

-- Recommended to use lua template string
local hjkl = [[hjklpae']]
local phae = [[phaek'lj]]
local hjkl_shift = [[HJKLPAE"]]
local phae_shift = [[PHAEK"LJ]]

vim.opt.langmap = vim.fn.join({
  -- | `to` should be first     | `from` should be second
  escape(phae_shift)
    .. ";"
    .. escape(hjkl_shift),
  escape(phae) .. ";" .. escape(hjkl),
}, ",")
