-- ============================================================================
-- GLOBAL AUTO-COMMANDS (AUTOCMDS)
-- ============================================================================
-- Purpose: Trigger actions on Neovim events (yanking, buffer changes, terminal)
-- ============================================================================

-- Brief visual "flash" when copying (yanking) text
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

-- Automatically clean up terminal buffers when shell exits
vim.api.nvim_create_autocmd("TermClose", {
	callback = function()
		vim.cmd("bwipeout!")
	end,
})

-- Prevent E948 (Job still running) and E676 (No matching autocommands for buftype) when quitting
vim.api.nvim_create_autocmd("QuitPre", {
	callback = function()
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_is_valid(buf) then
				local buftype = vim.bo[buf].buftype
				if buftype == "terminal" then
					-- Force close terminal buffers to prevent E948
					vim.cmd("silent! bwipeout! " .. buf)
				elseif buftype ~= "" then
					-- Mark other special buffers (nofile, acwrite) as unmodified so Neovim doesn't try to write them
					pcall(function()
						vim.bo[buf].modified = false
					end)
				end
			end
		end
	end,
})

-- Project root auto-detection (for consistent LSP and Telescope working directories)
vim.api.nvim_create_autocmd({ "BufEnter", "VimEnter" }, {
	pattern = "*",
	callback = function()
		local root_patterns = { ".git", "package.json", "pyproject.toml", "Cargo.toml", "go.mod" }
		local root = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1] or "")
		if root ~= "" and root ~= vim.fn.getcwd() then
			vim.cmd.cd(root)
		end
	end,
})
