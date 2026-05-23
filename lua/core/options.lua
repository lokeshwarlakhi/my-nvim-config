-- ============================================================================
-- CORE OPTIONS
-- ============================================================================
-- Purpose: Setup base Vim settings (tabs, splits, clipboard, undo, layout)
-- Centralized: Loads settings dynamically from config/settings.lua
-- ============================================================================

local opt = vim.opt
local settings = require("config.settings")

-- Disable unused providers (removes checkhealth warnings)
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Session Management
opt.sessionoptions = settings.get("editor.sessionoptions", "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions")

-- File Handling & Backup
opt.errorbells = false
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = settings.get("paths.undo_dir", os.getenv("HOME") .. "/.vim/undodir")
opt.scrolloff = 8
opt.updatetime = 50
opt.autoread = true

-- Line Numbers Configuration
local line_numbers = settings.get("editor.line_numbers", "both")
if line_numbers == "both" then
  opt.number = true
  opt.relativenumber = true
elseif line_numbers == "relative" then
  opt.number = false
  opt.relativenumber = true
elseif line_numbers == "absolute" then
  opt.number = true
  opt.relativenumber = false
else
  opt.number = false
  opt.relativenumber = false
end

-- Tabs & Indentation
local tab_width = settings.get("editor.tab_width", 2)
local use_spaces = settings.get("editor.use_spaces", true)
opt.tabstop = tab_width
opt.shiftwidth = tab_width
opt.expandtab = use_spaces
opt.autoindent = true
vim.bo.softtabstop = tab_width

-- Line Wrapping
opt.wrap = true
opt.linebreak = true -- Wrap lines at word boundaries
opt.breakindent = true -- Wrap lines maintain visual indent

-- Search Settings
opt.ignorecase = true
opt.smartcase = true

-- Cursor settings
opt.cursorline = true
local cursor_shape = settings.get("editor.cursor_shape", "block")
if cursor_shape == "block" then
  opt.guicursor = "n-v-c:block-Cursor,i-ci-ve:ver25-Cursor2"
else
  opt.guicursor = "n-v-c:ver25-Cursor,i-ci-ve:block-Cursor2"
end

-- Visuals & Theme support
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
vim.diagnostic.config({ float = { border = "rounded", wrap = true } })

-- Keyboards & Backspace
opt.backspace = "indent,eol,start"

-- Clipboard Integration (Use system clipboard)
opt.clipboard:append("unnamedplus")

-- Split Windows Layout
opt.splitright = true
opt.splitbelow = true

-- Extra Keywords config
opt.iskeyword:append("-")

-- Mouse Support
local mouse_enabled = settings.get("editor.mouse_enabled", false)
if mouse_enabled then
  opt.mouse = "a"
else
  opt.mouse = ""
end
