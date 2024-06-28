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
-- map("n", "<C-E>", "5<C-E>")

-- Quit
delmap("n", "<leader>qq")
map("n", "<leader>qa", "<cmd>qa<cr>", { desc = "Quit All" })
map("n", "<leader>qx", "<cmd>xa<cr>", { desc = "Save & Quit All" })

-- Buffers
map("n", "<leader>[", "<C-^>", { desc = "Switch to Last Buffer" })
delmap("n", "<leader>bb")
delmap("n", "<leader>`")

-- Remove LazyVim keymaps
-- Files
delmap("n", "<leader>ft")
delmap("n", "<leader>fT")
delmap("n", "<leader>fn")
delmap("n", "<leader>l")
delmap("n", "<leader>L")

-- PHAE keymaps
map("n", "<C-L>", "5<C-E>")
map("n", "<C-K>", "<C-P>")

-- References
-- local nav_to = "hjklpae'"
-- local nav_from = "phaek'lj"
-- local nav_to_shift = 'HJKLPAE"'
-- local nav_from_shift = 'PHAEK"LJ'
local others_from = "k'lj"
local others_to = "pae'"
local others_from_shift = 'K"LJ'
local others_to_shift = 'PAE"'
local nav_from = "phae"
local nav_to = "hjkl"
local nav_from_shift = "PHAE"
local nav_to_shift = "HJKL"

-- Function to create mappings
local function map_keys(from, to, modes, opts)
  for i = 1, #from do
    local from_char = from:sub(i, i)
    local to_char = to:sub(i, i)
    for _, mode in ipairs(modes) do
      vim.keymap.set(mode, from_char, to_char, opts)
    end
  end
end

-- List of modes to apply the mappings
local modes = { "n", "o" }

-- Map lowercase keys
map_keys(nav_from, nav_to, modes, { noremap = true, silent = true })
map_keys(nav_from, nav_to, { "x" }, { noremap = true, silent = true })
map_keys(others_from, others_to, modes, { noremap = true, silent = true })
map_keys("'", "a", { "x", "o" }, { noremap = true, silent = true })

-- Map uppercase (shift) keys
map_keys(nav_from_shift, nav_to_shift, modes, { noremap = true, silent = true })
map_keys(nav_from_shift, nav_to_shift, { "x" }, { noremap = true, silent = true })
map_keys(others_from_shift, others_to_shift, modes, { noremap = true, silent = true })
map_keys("L", "E", { "x" }, { noremap = true, silent = true })
