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

-- -- PHAE keymaps
-- map("n", "<C-L>", "5<C-E>")
-- map("n", "<C-K>", "<C-P>")

-- References
-- local nav_to = "hjklpae'"
-- local nav_from = "phaek'lj"
-- local nav_to_shift = 'HJKLPAE"'
-- local nav_from_shift = 'PHAEK"LJ'
--
-- local others_from = "k'lj"
-- local others_to = "pae'"
-- local others_from_shift = 'K"LJ'
-- local others_to_shift = 'PAE"'
--
-- local nav_from = "phae"
-- local nav_to = "hjkl"
-- local nav_from_shift = "PHAE"
-- local nav_to_shift = "HJKL"

-- KHAE navkeymaps
map({ "n", "x" }, "<C-L>", "5<C-E>")
map({ "n", "x" }, "gl", "ge", { desc = "Go to previous word end" })
map({ "n", "x" }, "ge", "$", { desc = "Go to end of line" })
map({ "n", "x" }, "gk", "^", { desc = "Go to beginning of line" })

local others_from = "'lj"
local others_to = "ae'"
local others_from_shift = '"LJ'
local others_to_shift = 'AE"'

local nav_from = "khae"
local nav_to = "hjkl"
local nav_from_shift = "KHAE"
local nav_to_shift = "HJKL"

-- Function to create mappings
local function map_keys(from, to, modes)
  local opts = { noremap = true, silent = true }
  for i = 1, #from do
    local from_char = from:sub(i, i)
    local to_char = to:sub(i, i)
    for _, mode in ipairs(modes) do
      vim.keymap.set(mode, from_char, to_char, opts)
    end
  end
end

-- List of modes to apply the mappings
local modes = { "n", "x" }

-- Map lowercase keys
-- Use better up/down for jk
map_keys("ke", "hl", modes)
map({ "n", "x" }, "h", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "a", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
-- For nav keys, can map 'o' mode
map_keys(nav_from, nav_to, { "o" })
-- leave l=>e to nvim-spider ind all 3 modes
-- leave '=>a in 'x' and 'o' mode to mini.ai
map_keys("'j", "a'", { "n" })
map_keys("j", "'", { "x", "o" })

-- Map uppercase (shift) keys
-- shifted keys are mostly unused in 'o' mode
-- leave A->K to lsp Hover
map_keys("KHE", "HJL", modes)
map_keys(nav_from_shift, nav_to_shift, { "o" })
map_keys(others_from_shift, others_to_shift, modes)
map_keys(others_from_shift, others_to_shift, { "o" })
