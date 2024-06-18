local opt = vim.opt

-- Session Management
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions" -- Options to store in a session

-- Line Numbers
opt.relativenumber = false -- Disable relative line numbers
opt.number = true -- Enable absolute line numbers

-- Tabs & Indentation
opt.tabstop = 2 -- Number of spaces a <Tab> counts for
opt.shiftwidth = 2 -- Number of spaces for indentation
opt.expandtab = true -- Convert tabs to spaces
opt.autoindent = true -- Maintain indent of current line
vim.bo.softtabstop = 2 -- Number of spaces a <Tab> counts for in buffer

-- Line Wrapping
opt.wrap = true -- Enable line wrapping

-- Search Settings
opt.ignorecase = true -- Ignore case in search patterns
opt.smartcase = true -- Override ignorecase if search pattern contains uppercase

-- Cursor Line
opt.cursorline = true -- Highlight the current line

-- Appearance
opt.termguicolors = true -- Enable 24-bit RGB color in the TUI
opt.background = "dark" -- Set background color scheme
opt.signcolumn = "yes" -- Always show the sign column
vim.diagnostic.config { float = { border = "rounded" } } -- Add border to diagnostic popups

-- Backspace
opt.backspace = "indent,eol,start" -- Configure backspace behavior

-- Clipboard
opt.clipboard:append("unnamedplus") -- Use system clipboard

-- Split Windows
opt.splitright = true -- Vertical splits open to the right
opt.splitbelow = true -- Horizontal splits open below

-- Consider - as part of keyword
opt.iskeyword:append("-") -- Include hyphen in keywords

-- Disable the mouse while in nvim
opt.mouse = "" -- Disable mouse support

-- Folding
opt.foldlevel = 20 -- Set fold level
opt.foldmethod = "expr" -- Use expression for folding
opt.foldexpr = "nvim_treesitter#foldexpr()" -- Utilize Treesitter folds

--Buffer-Line
opt.termguicolors = true
require("bufferline").setup{}
