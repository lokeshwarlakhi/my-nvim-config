-- Set leader key early
vim.opt.mouse = "" -- Disable mouse support
vim.g.mapleader = " " -- Set space as the leader key
-- vim.g.loaded_node_provider = 0
-- vim.g.loaded_python3_provider = 0
-- vim.g.loaded_perl_provider = 0

-- Load core settings
-- =======================
--[[
In Neovim's Lua module system, the lua directory in your config folder (~/.config/nvim/lua/) is automatically treated as the root of your Lua module path. This means:

require("core.options") correctly loads options.lua
require("lua.core.options") would incorrectly look for lua/lua/core/options.lua (which doesn't exist)
The lua prefix is implicit in Neovim's runtime path setup, so you don't need to include it in your require() statements. This is why all your plugin and core module loads use the shorter form like require("core.options") and require("plugins.lsp").
--]]
require("core.options") -- Basic Neovim settings (like indentation, search behavior, etc.)
require("core.keymaps") -- Custom key mappings for better workflow
require("core.autocmds") -- Auto commands for specific file types or events


-- Terminal Cleanup on Startup
--[[
Creates an autocommand that runs when Neovim starts (VimEnter)
Clears the terminal screen and redraws the interface
]]
vim.cmd("hi Normal guibg=NONE ctermbg=NONE")

-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({ -- vim.fn.system(...): Runs a shell command from within Neovim.
		"git",
		"clone",
		"--filter=blob:none", --A "blobless" clone that makes the download significantly faster by only grabbing the file history it needs.
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", --Specifically downloads the latest stable version of the plugin manager rather than the experimental development version.

		lazypath,
	})
end
--[[
local lazypath: Creates a local variable named lazypath to hold the resulting string.

vim.fn.stdpath("data"): Calls a Neovim function to get the "standard data path" for your operating system. 
-- Linux/macOS: Typically ~/.local/share/nvim
-- Windows: Typically ~\AppData\Local\nvim-data

.. : The Lua operator for string concatenation (joining two strings together).

"/lazy/lazy.nvim": Appends the specific subfolder name to the data path.
--]]

vim.opt.rtp:prepend(lazypath) --This adds the newly downloaded lazy.nvim folder to the very beginning of Neovim's runtimepath.
-- Why? By putting it at the front, Neovim can immediately find and run the require("lazy") command that usually follows this block, allowing the manager to take over and install the rest of your plugins.

-- Load plugins
require("lazy").setup("plugins", {
	change_detection = {
		enabled = true,
		notify = false,
	},
})
--[[
1. require("lazy").setup("plugins", ...)
This tells lazy.nvim to initialize itself.
The "plugins" argument: This is a shortcut. It tells Lazy to look for a folder named lua/plugins/ in your Neovim configuration directory.
It will automatically "require" every .lua file inside that folder. This is the cleanest way to organize a config because you can give each plugin (like telescope.lua or lsp.lua) its own file.

2. change_detection
This block controls how lazy.nvim reacts when you save changes to your configuration files while Neovim is still running.
enabled = true: Lazy will stay "watching" your files in the background. If you add a new plugin to a file and hit save, Lazy will detect it immediately without you needing to restart Neovim.
notify = false: This is a popular quality-of-life setting. By default, every time you save a file and Lazy detects a change, it sends a pop-up notification saying "Config Change Detected. Reloading..." Setting this to false stops those annoying pop-ups while still keeping the auto-reload feature active.
--]]

-- Load colorscheme after plugins
-- vim.cmd.colorscheme("habamax") -- Default, replace with your preferred scheme
