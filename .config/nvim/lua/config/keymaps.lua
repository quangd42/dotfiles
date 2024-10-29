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
-- qwerty home end
map({ "n", "x" }, "gh", "^", { desc = "Go to Beginning of Line" })
map({ "n", "x" }, "gl", "$", { desc = "Go to End of Line" })

-- Move screen
map("n", "<C-Y>", "5<C-Y>")
map("n", "<C-E>", "5<C-E>")

-- Quit
delmap("n", "<leader>qq")
map("n", "<leader>qa", "<cmd>qa<cr>", { desc = "Quit All" })
map("n", "<leader>qx", "<cmd>xa<cr>", { desc = "Save & Quit All" })

-- Buffers
map("n", "<leader>[", "<C-^>", { desc = "Switch to Last Buffer" })
map("n", "<leader>`", "<C-^>", { desc = "Switch to Last Buffer" })
delmap("n", "<leader>bb")
-- delmap("n", "<leader>`")
delmap("n", "<leader>bd")
delmap("n", "<leader>bD")

-- Remove LazyVim keymaps
-- Files
delmap("n", "<leader>ft")
delmap("n", "<leader>fT")
delmap("n", "<leader>fn")
delmap("n", "<leader>l")
delmap("n", "<leader>L")
