-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
local map = vim.keymap.set

-- Yank
map('n', 'Y', 'y$', { desc = 'Yank Till End Of Line' })
-- Redo
map('n', 'U', '<C-R>', { desc = 'Redo Last Change' })
-- Visual mode copy paste
map('v', 'C', '"_c', { desc = 'Change Without Yank' })
map('v', 'D', '"_d', { desc = 'Delete Without Yank' })
-- remap gx
map({ 'n', 'x' }, 'go', 'gx', { desc = 'Open filepath or URI under cursor with system handler' })

-- Move screen
map('n', '<C-Y>', function()
  require('neoscroll').scroll(-5, { move_cursor = false, duration = 250 })
end, { desc = 'which_key_ignore' })
map('n', '<C-E>', function()
  require('neoscroll').scroll(5, { move_cursor = false, duration = 250 })
end, { desc = 'which_key_ignore' })

-- Buffers
map('n', '<leader>[', '<C-^>', { desc = 'which_key_ignore' })
map('n', '<leader>`', '<C-^>', { desc = 'which_key_ignore' })

-- Commenting
map({ 'n', 'x' }, '<D-/>', '<cmd>norm gcc<cr>', { desc = 'Toggle Commenting' })

-- Tabs
map('n', ']<tab>', '<cmd>tabnext<cr>', { desc = 'Next tab' })
map('n', '[<tab>', '<cmd>tabprevious<cr>', { desc = 'Previous tab' })

-- Diagnostic keymaps
-- map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- [[ Yoinked from LazyVim ]]

-- better up/down
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
map({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>', { desc = 'Escape and Clear hlsearch' })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next Search Result' })
map('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev Search Result' })

-- Add undo break-points
map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', ';', ';<c-g>u')

-- highlights under cursor
map('n', '<leader>ui', vim.show_pos, { desc = 'Inspect Pos' })
map('n', '<leader>uI', '<cmd>InspectTree<cr>', { desc = 'Inspect Tree' })

-- windows
map('n', '<leader>-', '<C-W>s', { desc = 'Split Window Below' })
map('n', '<leader>|', '<C-W>v', { desc = 'which_key_ignore' })
map('n', '<leader>\\', '<C-W>v', { desc = 'Split Window Right' })

-- vim: ts=2 sts=2 sw=2 et
