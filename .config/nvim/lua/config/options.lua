-- [[ Setting options ]]
-- See `:help vim.opt`
--  For more options, you can see `:help option-list`

local opt = vim.opt

-- Make line numbers default
opt.number = true
-- You can also add relative line numbers, to help with jumping.
opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
  opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = 'yes'

-- Decrease update time - Save swap file and trigger CursorHold
opt.updatetime = 200

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
opt.timeoutlen = 300

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
opt.inccommand = 'split'

-- Show which line your cursor is on
opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10
opt.sidescrolloff = 8

-- Steal from LazyVim
opt.shortmess:append { W = true, I = true, c = true, C = true }
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' }
opt.virtualedit = 'block' -- Allow cursor to move where there is no text in visual block mode
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent (in space)
opt.tabstop = 2 -- Size of a tab character
-- opt.pumblend = 10 -- Popup blend
-- opt.pumheight = 10 -- Maximum number of entries in a popup
opt.termguicolors = true -- True color support
opt.wildmode = 'longest:full,full' -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.confirm = true -- Confirm to save changes before exiting modified buffer

-- nvim-0.10
opt.smoothscroll = true

-- vim: ts=2 sts=2 sw=2 et
