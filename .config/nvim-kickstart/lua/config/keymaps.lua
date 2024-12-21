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

-- Move screen
map('n', '<C-Y>', '5<C-Y>', { desc = 'which_key_ignore' })
map('n', '<C-E>', '5<C-E>', { desc = 'which_key_ignore' })

-- Buffers
map('n', '<leader>[', '<C-^>', { desc = 'which_key_ignore' })
map('n', '<leader>`', '<C-^>', { desc = 'which_key_ignore' })

-- Commenting
map({ 'n', 'x' }, '<D-/>', '<cmd>norm gcc<cr>', { desc = 'Toggle Commenting' })

-- Tabs
map('n', ']<tab>', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
map('n', '[<tab>', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })

-- For working in config
map('n', '<leader>X', ':w<cr>:source %<cr>')

-- Diagnostic keymaps
-- map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- [[ Yoinked from LazyVim ]]

-- better up/down
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
map({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map('n', '<C-h>', '<C-w>h', { desc = 'Go to Left Window', remap = true })
map('n', '<C-j>', '<C-w>j', { desc = 'Go to Lower Window', remap = true })
map('n', '<C-k>', '<C-w>k', { desc = 'Go to Upper Window', remap = true })
map('n', '<C-l>', '<C-w>l', { desc = 'Go to Right Window', remap = true })

-- Resize window using <ctrl> arrow keys
map('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
map('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

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

-- diagnostic
map('n', '<leader>k', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Next Diagnostic' })
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev Diagnostic' })

-- windows
map('n', '<leader>w', '<c-w>', { desc = 'Windows' })
map('n', '<leader>-', '<C-W>s', { desc = 'Split Window Below' })
map('n', '<leader>|', '<C-W>v', { desc = 'Split Window Right' })
map('n', '<leader>wd', '<C-W>c', { desc = 'Delete Window', remap = true })

-- stylua: ignore start

-- lazygit
if vim.fn.executable("lazygit") == 1 then
  map("n", "<leader>gg", function() Snacks.lazygit( { cwd = vim.fs.root(0, ".git") }) end, { desc = "Lazygit (Root Dir)" })
  map("n", "<leader>gb", function() Snacks.git.blame_line() end, { desc = "Git Blame Line" })
  map({ "n", "x" }, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse" })
  map("n", "<leader>gf", function() Snacks.lazygit.log_file() end, { desc = "Lazygit Current File History" })
  map("n", "<leader>gl", function() Snacks.lazygit.log({ cwd = vim.fs.root(0, ".git") }) end, { desc = "Lazygit Log" })
  map("n", "<leader>gL", function() Snacks.lazygit.log() end, { desc = "Lazygit Log (cwd)" })
end

-- vim: ts=2 sts=2 sw=2 et
