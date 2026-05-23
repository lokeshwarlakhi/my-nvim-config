-- ============================================================================
-- GLOBAL KEYMAPS
-- ============================================================================
-- Purpose: Global keybindings for navigation, buffers, windows, and tools
-- ============================================================================

local keymap = vim.keymap

-- Set leader is already set in init.lua, do not override here.

-- ============================================================================
-- GENERAL EDITING & NAVIGATION
-- ============================================================================

-- Exit insert mode quickly with jk
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- Clear search highlights
keymap.set("n", "<leader>u", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Open URL under cursor
keymap.set("n", "gx", ":!open <c-r><c-a><CR>", { desc = "Open URL under cursor" })

-- Move lines up and down (like VSCode Alt+Up/Down)
keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move lines down" })
keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move lines up" })

-- ============================================================================
-- BUFFER & TAB MANAGEMENT (Bufferline Integrated)
-- ============================================================================

-- Switch between buffers (next / prev)
keymap.set("n", "<leader>n", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer tab" })
keymap.set("n", "<leader>p", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer tab" })

keymap.set("n", "<leader>x", function()
	local buf = vim.api.nvim_get_current_buf()
	local buftype = vim.bo[buf].buftype
	if buftype == "terminal" then
		vim.cmd("silent! bwipeout!")
		return
	end

	if vim.bo[buf].modified then
		local choice = vim.fn.confirm("Save changes?", "&Yes\n&No\n&Cancel", 1)
		if choice == 1 then
			vim.cmd("write")
		elseif choice == 3 then
			return
		end
	end

	local alternate = vim.fn.bufnr("#")
	if alternate > 0 and vim.fn.buflisted(alternate) == 1 then
		vim.cmd("buffer #")
		vim.cmd("silent! bdelete! " .. buf)
	else
		local buffers = vim.fn.getbufinfo({ buflisted = 1 })
		local next_buf = nil
		for _, b in ipairs(buffers) do
			if b.bufnr ~= buf then
				next_buf = b.bufnr
				break
			end
		end
		if next_buf then
			vim.api.nvim_set_current_buf(next_buf)
			vim.cmd("silent! bdelete! " .. buf)
		else
			vim.cmd("silent! bdelete!")
		end
	end
end, { desc = "Close current buffer safely" })

-- Save and Quit shortcuts
keymap.set("n", "<leader>ww", "<cmd>wa<CR>", { desc = "Save all buffers" })
keymap.set("n", "<leader>wq", "<cmd>wq<CR>", { desc = "Save and close" })
keymap.set("n", "<leader>qq", "<cmd>q!<CR>", { desc = "Force quit without saving" })

-- Tab navigation (if tabs are preferred over buffer tabs)
keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "New tab page" })
keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close tab page" })
keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = "Next tab page" })
keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = "Previous tab page" })

-- ============================================================================
-- WINDOW SPLIT MANAGEMENT
-- ============================================================================

-- Split window commands
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close current split window" })

-- Window navigation (arrows or standard hjkl)
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize window splits (fixed conflict: <leader>sh is split horizontal, using arrow-keys or <leader>s...)
keymap.set("n", "<leader>sk", "<C-w>+", { desc = "Increase window height" })
keymap.set("n", "<leader>sj", "<C-w>-", { desc = "Decrease window height" })
keymap.set("n", "<leader>s>", "<C-w>>5", { desc = "Increase window width" })
keymap.set("n", "<leader>s<", "<C-w><5", { desc = "Decrease window width" })

-- ============================================================================
-- INTEGRATED TERMINAL KEYMAPS
-- ============================================================================

-- Create terminals in splits/tabs
keymap.set("n", "<leader>th", ":split | term<CR>", { desc = "Terminal in horizontal split" })
keymap.set("n", "<leader>tv", ":vsplit | term<CR>", { desc = "Terminal in vertical split" })
keymap.set("n", "<leader>tt", ":tabnew | term<CR>", { desc = "Terminal in new tab" })

-- Exit terminal insert mode using jk
keymap.set("t", "jk", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- ============================================================================
-- PRODUCTIVITY TOOLS
-- ============================================================================

-- Neo-tree file explorer toggle and reveal
keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle file explorer" })
keymap.set("n", "<C-n>", "<cmd>Neotree filesystem reveal left<CR>", { desc = "Reveal file in explorer" })

-- Telescope fuzzy finder
keymap.set("n", "<leader>ff", function() require("telescope.builtin").find_files() end, { desc = "Find files" })
keymap.set("n", "<leader>fg", function() require("telescope.builtin").live_grep() end, { desc = "Search text (live grep)" })
keymap.set("n", "<leader>fb", function() require("telescope.builtin").buffers() end, { desc = "Find buffers" })
keymap.set("n", "<leader>fh", function() require("telescope.builtin").help_tags() end, { desc = "Search help tags" })
keymap.set("n", "<leader>fs", function() require("telescope.builtin").current_buffer_fuzzy_find() end, { desc = "Fuzzy search in buffer" })

-- LSP-related search keymaps (Telescope integrated)
keymap.set("n", "<leader>fo", function() require("telescope.builtin").lsp_document_symbols() end, { desc = "Fuzzy find document symbols" })
keymap.set("n", "<leader>fS", function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end, { desc = "Fuzzy find workspace symbols" })
keymap.set("n", "<leader>fm", function() require("telescope.builtin").treesitter({ symbols = { "function", "method" } }) end, { desc = "List methods & functions" })

-- ============================================================================
-- MERGE & DIFF SHORTCUTS
-- ============================================================================

keymap.set("n", "<leader>cc", ":diffput<CR>", { desc = "Diffput (send diff)" })
keymap.set("n", "<leader>cj", ":diffget 1<CR>", { desc = "Diffget from Left (Local)" })
keymap.set("n", "<leader>ck", ":diffget 3<CR>", { desc = "Diffget from Right (Remote)" })
keymap.set("n", "<leader>cn", "]c", { desc = "Next diff change" })
keymap.set("n", "<leader>cp", "[c", { desc = "Previous diff change" })
