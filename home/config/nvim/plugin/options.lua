-- Global Neovim Options
local opt = vim.opt
local home = os.getenv("HOME")
local nvim_path = home .. "/.config/nvim"

-- Basic Essentials
opt.syntax = "on"             -- nvim default
opt.hidden = true             -- nvim default
opt.termguicolors = true
opt.scrolloff = 8             -- Cursor doesn't have to be at the end of the buffer to scroll
opt.clipboard = "unnamedplus" -- Use system clipboard

-- Tabs
opt.tabstop = 4 -- Width of tab
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true  -- Use spaces instead of tab
opt.autoindent = true -- Good for plain text

-- Proper Search
opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true  --... unless there is a capital letter in the query
opt.gdefault = true   -- global flag set as default for search and replace
opt.incsearch = true  -- Makes search act like search in modern browsers
opt.showmatch = true  -- Show matching brackets when cursor is over them
opt.hlsearch = false  -- Search highlighting; keymapping to turn it off

-- Sane Splits
opt.splitright = true
opt.splitbelow = true

-- Configure Folding
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
opt.foldenable = false -- start editing with all folds open

-- https://www.gilesorr.com/blog/vim-tips-22-modelines.html
opt.modeline = false

-- https://vi.stackexchange.com/questions/6/how-can-i-use-the-undofile
-- Backup Files Location
opt.backupdir = nvim_path .. "/tmp/backup"
-- Swap Files Location
opt.directory = nvim_path .. "/tmp/swap"
-- Undo Files Location
opt.undodir = nvim_path .. "/tmp/undo"
opt.undofile = true

-- Configure Line No.
opt.number = true         -- Show line no. where the cursor is on
opt.relativenumber = true -- Show relative line no.
opt.numberwidth = 1       -- Width of the Col in terms of # of chars

-- Colors
-- NOTE: Group colors (e.g., SignColumn, ColorColumn, CursorLine, CursorLineNr, LineNr, etc.)
-- can be set in their respective colorscheme
opt.colorcolumn = "80" -- Bar to prevent going 80 char in a line
opt.cursorline = true

-- Configure Cursor
-- https://stackoverflow.com/questions/6488683/how-to-change-the-cursor-between-normal-and-insert-modes-in-vim/6489348#6489348
-- Enable blinking vertical cursor when in Insert Mode and No blinking in Insert/Visual
opt.guicursor:append 'n-v-c:blinkon0,i-ci:ver25-Cursor/lCursor-blinkwait30-blinkoff100-blinkon100'
