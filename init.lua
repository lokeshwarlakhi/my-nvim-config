-- Set leader key early (MUST be set before loading plugins/keymaps)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable mouse support (as requested)
vim.opt.mouse = ""

-- Load core settings
require("core.options")   -- Basic Neovim settings
require("core.keymaps")   -- Custom key mappings
require("core.autocmds")  -- Auto commands

-- Terminal background transparency adjustment
vim.cmd("hi Normal guibg=NONE ctermbg=NONE")

-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Initialize dynamic language orchestrator
-- This loads and registers LSPs, formatters, and linters from lua/languages/*
require("languages")

-- Load plugins via lazy.nvim
require("lazy").setup("plugins", {
	change_detection = {
		enabled = true,
		notify = false,
	},
})
