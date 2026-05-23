-- Set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

-- =======================================================================================================
-- Buffer
keymap.set("n", "<leader>n", ":bn<CR>")
keymap.set("n", "<leader>p", ":bp<CR>")
keymap.set("n", "<leader>x", ":bd<CR>")

-- =======================================================================================================
-- General keymaps
keymap.set("i", "jk", "<ESC>") -- exit insert mode with jk
vim.keymap.set("n", "<C-h>", "<C-w>h") -- move cursor to the right pane
vim.keymap.set("n", "<C-l>", "<C-w>l") -- move cursor to the left pane

keymap.set("i", "<c-k>", "<Esc>:m .-2<CR>==gi") -- move current line up in insert mode
keymap.set("i", "<c-j>", "<Esc>:m .+1<CR>==gi") -- move current line down in insert mode
keymap.set("v", "<c-j>", ":m '>+1<CR>gv=gv") -- move selected lines down in visual mode
keymap.set("v", "<c-k>", ":m '<-2<CR>gv=gv") -- move selected lines up in visual mode
keymap.set("n", "<c-j>", ":m .+1<CR>==") -- move current line down in normal mode
keymap.set("n", "<c-k>", ":m .-2<CR>==") -- move current line up in normal mode
keymap.set("n", "<leader>wq", ":wq<CR>") -- save and quit
keymap.set("n", "<leader>qq", ":q!<CR>") -- quit without saving
keymap.set("n", "<leader>ww", ":wa<CR>") -- save
keymap.set("n", "gx", ":!open <c-r><c-a><CR>") -- open URL under cursorline
vim.keymap.set("n", "<leader>u", "<cmd>nohlsearch<CR>")

-- TERMINAL SETTINGS:
-- =======================================================================================================
-- Open terminal in a horizontal split
vim.keymap.set("n", "<leader>th", ":split | term<CR>", { desc = "Terminal Horizontal" })

-- Open terminal in a vertical split
vim.keymap.set("n", "<leader>tv", ":vsplit | term<CR>", { desc = "Terminal Vertical" })

-- Open terminal in a new tab
vim.keymap.set("n", "<leader>tt", ":tabnew | term<CR>", { desc = "Terminal New Tab" })

-- Use Esc to exit terminal mode
vim.keymap.set("t", "jk", [[<C-\><C-n>]], { desc = "Exit Terminal Mode" })

-- =======================================================================================================
-- Telescope keymaps with lazy loading
-- Find files
keymap.set("n", "<leader>ff", function()
	require("telescope.builtin").find_files()
end, {})
-- Live grep
keymap.set("n", "<leader>fg", function()
	require("telescope.builtin").live_grep()
end, {})
-- Find buffers
keymap.set("n", "<leader>fb", function()
	require("telescope.builtin").buffers()
end, {})
-- Help tags
keymap.set("n", "<leader>fh", function()
	require("telescope.builtin").help_tags()
end, {})
-- Current buffer fuzzy find
keymap.set("n", "<leader>fs", function()
	require("telescope.builtin").current_buffer_fuzzy_find()
end, {})
-- LSP document symbols
keymap.set("n", "<leader>fo", function()
	require("telescope.builtin").lsp_document_symbols()
end, {})
-- LSP incoming calls
keymap.set("n", "<leader>fi", function()
	require("telescope.builtin").lsp_incoming_calls()
end, {})
-- Treesitter methods/functions
keymap.set("n", "<leader>fm", function()
	require("telescope.builtin").treesitter({ symbols = { "function", "method" } })
end, {})

-- Grep in nvim-tree node
keymap.set("n", "<leader>ft", function()
	local success, node = pcall(function()
		return require("nvim-tree.lib").get_node_at_cursor()
	end)
	if not success or not node then
		return
	end
	require("telescope.builtin").live_grep({ search_dirs = { node.absolute_path } })
end, {})

-- =======================================================================================================
-- Split window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width
keymap.set("n", "<leader>sx", ":close<CR>") -- close split window
keymap.set("n", "<leader>sj", "<C-w>-") -- make split window height shorter
keymap.set("n", "<leader>sk", "<C-w>+") -- make split windows height taller
keymap.set("n", "<leader>sh", "<C-w><5") -- make split windows width smaller
keymap.set("n", "<leader>sl", "<C-w>>5") -- make split windows width bigger

-- Diagnostics
keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic float" })

-- Tab management
keymap.set("n", "<leader>to", ":tabnew<CR>") -- open a new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close a tab
keymap.set("n", "<leader>tn", ":tabn<CR>") -- next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") -- previous tab

-- Diff keymaps
keymap.set("n", "<leader>cc", ":diffput<CR>") -- put diff from current to other during diff
keymap.set("n", "<leader>cj", ":diffget 1<CR>") -- get diff from left (local) during merge
keymap.set("n", "<leader>ck", ":diffget 3<CR>") -- get diff from right (remote) during merge
keymap.set("n", "<leader>cn", "]c") -- next diff hunk
keymap.set("n", "<leader>cp", "[c") -- previous diff hunk

-- Nvim-tree
keymap.set("n", "<leader>ee", ":Neotree close<CR>") -- toggle file explorer
keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>")
-- keymap.set("n", "<C-n>", ":NvimTreeFindFile<CR>") -- find file in file explorer
