-- kitty-scrollback-nvim-kitten-config.lua

-- put your general Neovim configurations here
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- add kitty-scrollback.nvim to the runtimepath to allow us to require the kitty-scrollback module
-- pick a runtimepath that corresponds with your package manager, if you are not sure leave them all it will not cause any issues
vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/lazy/kitty-scrollback.nvim") -- lazy.nvim
require("kitty-scrollback").setup({
  -- put your kitty-scrollback.nvim configurations here
})

-- tokyonight
-- vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/lazy/tokyonight.nvim")
-- require("tokyonight").setup({ style = "moon" })
-- vim.cmd([[colorscheme tokyonight]])
-- catppuccin
vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/lazy/catppuccin")
require("catppuccin").setup()
vim.cmd([[colorscheme catppuccin]])

vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/lazy/flash.nvim")
require("flash").setup()
local map = vim.keymap.set
map({ "n", "x", "o" }, "s", function()
  require("flash").jump()
end, { desc = "Flash" })
map({ "n", "o", "x" }, "S", function()
  require("flash").treesitter()
end, { desc = "Flash Treesitter" })
map({ "o", "x" }, "R", function()
  require("flash").treesitter_search()
end, { desc = "Treesitter Search" })

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
