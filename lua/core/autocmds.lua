-- This block of code creates an autocommand that gives you a brief visual "flash" whenever you copy (yank) text. It’s a popular modern feature that confirms your action was successful.
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 150,
			on_visual = true,
		})
	end,
})
--[[
Here is the detailed breakdown:
----------------------------------
1. The Trigger: vim.api.nvim_create_autocmd
This function tells Neovim to "watch" for a specific event and run a function when it happens.

- "TextYankPost": This is the specific event. It triggers immediately after you press y (yank) or any other command that copies text to a register.

- pattern = "*": This means the rule applies to every file type and every buffer you open in Neovim.

2. The Action: callback = function() ... end
This is the "payload"—the actual code that runs when the event is triggered. It calls a built-in Neovim function: vim.highlight.on_yank.

3. The Visual Settings
Inside the highlight function, you are passing a table of options:

- higroup = "IncSearch": This determines the color. It tells Neovim to use the same highlight group used for "Incremental Search" (usually a bright, high-contrast color like orange or yellow).

- timeout = 150: This is the duration in milliseconds. 150 is a very fast "flash" (about 0.15 seconds). If you change this to 500, the highlight will stay on the screen for half a second.

- on_visual = true: By default, some versions of this function only flash when you yank in "Normal" mode (e.g., typing yy). Setting this to true ensures it also flashes when you have text selected in Visual Mode and hit y.

Why Neovim users love this:
-----------------------------
In traditional Vim, when you yank a paragraph, nothing happens on the screen. You just have to trust that the text is in your clipboard. This script adds instant feedback, making the editor feel much more responsive and modern.
]]

-- This code creates an autocommand that automatically changes Neovim's working directory to the folder containing the file you just opened.
vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	callback = function(args)
		-- Only change if opening a file (not just `nvim` with no args)
		if args.file and #args.file > 0 then
			local dir = vim.fn.fnamemodify(args.file, ":h")
			if dir ~= "." and vim.fn.isdirectory(dir) == 1 then
				vim.cmd.cd(dir) -- Change to file's directory
			end
		end
	end,
})
--[[
Detailed Breakdown
----------------------
VimEnter: This event triggers exactly once, right after Neovim finishes starting up.

callback = function(args): This function runs when you launch Neovim. The args table contains information about how you started the editor (like which file you opened).

if args.file and #args.file > 0 then: This check ensures the code only runs if you actually provided a filename (e.g., nvim main.py). If you just type nvim by itself, the script does nothing.

vim.fn.fnamemodify(args.file, ":h"): This extracts the head (the folder path) from the file you opened.

vim.fn.isdirectory(dir) == 1: It double-checks that the path is a valid folder on your computer.

vim.cmd.cd(dir): This executes the standard :cd command to move Neovim's "focus" into that folder.

Why This is Useful
-------------------
By default, Neovim stays in the folder where you were when you typed the command. If you are in your ~/Documents folder but open ~/Projects/website/index.html, Neovim usually stays in ~/Documents.
This script forces Neovim to "follow" you into ~/Projects/website/, which makes it much easier to save new files, browse related files, or run terminal commands in the correct project context.
]]

-- Optional: Auto-detect project root (for LSP/telescope)
vim.api.nvim_create_autocmd({ "BufEnter", "VimEnter" }, {
	pattern = "*",
	callback = function()
		local root_patterns = { ".git", "package.json", "pyproject.toml" }
		local root = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1] or "")
		if root ~= "" and root ~= vim.fn.getcwd() then
			vim.cmd.cd(root)
		end
	end,
})

vim.api.nvim_create_autocmd("TermClose", {
	callback = function()
		vim.cmd("bwipeout!")
	end,
})
