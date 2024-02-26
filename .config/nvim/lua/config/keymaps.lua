-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Yank
vim.keymap.set("n", "Y", "y$", { desc = "Yank till end of line" })
-- Redo
vim.keymap.set("n", "U", "<C-R>", { desc = "Redo last change" })
-- Visual mode copy paste
vim.keymap.set("v", "C", '"_c', { desc = "Change without yank" })
vim.keymap.set("v", "D", '"_d', { desc = "Delete without yank" })
