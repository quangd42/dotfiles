-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local delmap = vim.keymap.del

-- Yank
map("n", "Y", "y$", { desc = "Yank Till End Of Line" })
-- Redo
map("n", "U", "<C-R>", { desc = "Redo Last Change" })
-- Visual mode copy paste
map("v", "C", '"_c', { desc = "Change Without Yank" })
map("v", "D", '"_d', { desc = "Delete Without Yank" })

-- Move screen
map("n", "<C-Y>", "5<C-Y>")
map("n", "<C-E>", "5<C-E>")
