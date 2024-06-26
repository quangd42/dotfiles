-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
-- local delmap = vim.keymap.del
-- Yank
map("n", "Y", "y$", { desc = "Yank till end of line" })
-- Redo
map("n", "U", "<C-R>", { desc = "Redo last change" })
-- Visual mode copy paste
map("v", "C", '"_c', { desc = "Change without yank" })
map("v", "D", '"_d', { desc = "Delete without yank" })

-- Move screen
map("n", "<C-E>", "5<C-E>")
map("n", "<C-Y>", "5<C-Y>")
