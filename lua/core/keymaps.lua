-- Set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

-- General keymaps
keymap.set("i", "jk", "<ESC>") -- exit insert mode with jk
keymap.set("i", "<c-k>", "<Esc>:m .-2<CR>==gi") -- move current line up in insert mode
keymap.set("i", "<c-j>", "<Esc>:m .+1<CR>==gi") -- move current line down in insert mode
keymap.set("v", "<c-j>", ":m '>+1<CR>gv=gv") -- move selected lines down in visual mode
keymap.set("v", "<c-k>", ":m '<-2<CR>gv=gv") -- move selected lines up in visual mode
keymap.set("n", "<c-j>", ":m .+1<CR>==") -- move current line down in normal mode
keymap.set("n", "<c-k>", ":m .-2<CR>==") -- move current line up in normal mode
keymap.set("i", "ii", "<ESC>") -- exit insert mode with ii
keymap.set("n", "<leader>wq", ":wq<CR>") -- save and quit
keymap.set("n", "<leader>qq", ":q!<CR>") -- quit without saving
keymap.set("n", "<leader>ww", ":w<CR>") -- save
keymap.set("n", "gx", ":!open <c-r><c-a><CR>") -- open URL under cursor

-- Split window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width
keymap.set("n", "<leader>sx", ":close<CR>") -- close split window
keymap.set("n", "<leader>sj", "<C-w>-") -- make split window height shorter
keymap.set("n", "<leader>sk", "<C-w>+") -- make split windows height taller
keymap.set("n", "<leader>sl", "<C-w>>5") -- make split windows width bigger
keymap.set("n", "<leader>sh", "<C-w><5") -- make split windows width smaller

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

-- Quickfix keymaps
keymap.set("n", "<leader>qo", ":copen<CR>") -- open quickfix list
keymap.set("n", "<leader>qf", ":cfirst<CR>") -- jump to first quickfix list item
keymap.set("n", "<leader>qn", ":cnext<CR>") -- jump to next quickfix list item
keymap.set("n", "<leader>qp", ":cprev<CR>") -- jump to prev quickfix list item
keymap.set("n", "<leader>ql", ":clast<CR>") -- jump to last quickfix list item
keymap.set("n", "<leader>qc", ":cclose<CR>") -- close quickfix list

-- Vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle maximize tab

-- Nvim-tree
keymap.set("n", "<leader>ee", ":NvimTreeToggle<CR>") -- toggle file explorer
keymap.set("n", "<leader>er", ":NvimTreeFocus<CR>") -- toggle focus to file explorer
keymap.set("n", "<C-n>", ":NvimTreeFindFile<CR>") -- find file in file explorer

-- Telescope
keymap.set('n', '<C-p>', require('telescope.builtin').find_files, {}) -- find files
keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, {}) -- search text in files
keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, {}) -- list open buffers
keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, {}) -- search help tags
keymap.set('n', '<leader>fs', require('telescope.builtin').current_buffer_fuzzy_find, {}) -- search in current buffer
keymap.set('n', '<leader>fo', require('telescope.builtin').lsp_document_symbols, {}) -- search document symbols
keymap.set('n', '<leader>fi', require('telescope.builtin').lsp_incoming_calls, {}) -- search incoming calls
keymap.set('n', '<leader>fm', function() require('telescope.builtin').treesitter({default_text=":method:"}) end) -- search treesitter

-- Git-blame
keymap.set("n", "<leader>gb", ":GitBlameToggle<CR>") -- toggle git blame

-- Harpoon
keymap.set("n", "<leader>ha", require("harpoon.mark").add_file) -- add file to harpoon
keymap.set("n", "<leader>hh", require("harpoon.ui").toggle_quick_menu) -- toggle harpoon quick menu
keymap.set("n", "<leader>h1", function() require("harpoon.ui").nav_file(1) end) -- navigate to harpoon file 1
keymap.set("n", "<leader>h2", function() require("harpoon.ui").nav_file(2) end) -- navigate to harpoon file 2
keymap.set("n", "<leader>h3", function() require("harpoon.ui").nav_file(3) end) -- navigate to harpoon file 3
keymap.set("n", "<leader>h4", function() require("harpoon.ui").nav_file(4) end) -- navigate to harpoon file 4
keymap.set("n", "<leader>h5", function() require("harpoon.ui").nav_file(5) end) -- navigate to harpoon file 5
keymap.set("n", "<leader>h6", function() require("harpoon.ui").nav_file(6) end) -- navigate to harpoon file 6
keymap.set("n", "<leader>h7", function() require("harpoon.ui").nav_file(7) end) -- navigate to harpoon file 7
keymap.set("n", "<leader>h8", function() require("harpoon.ui").nav_file(8) end) -- navigate to harpoon file 8
keymap.set("n", "<leader>h9", function() require("harpoon.ui").nav_file(9) end) -- navigate to harpoon file 9

-- Vim REST Console
keymap.set("n", "<leader>xr", ":call VrcQuery()<CR>") -- run REST query

-- LSP
keymap.set('n', '<leader>gg', '<cmd>lua vim.lsp.buf.hover()<CR>') -- LSP hover
keymap.set('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>') -- LSP definition
keymap.set('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>') -- LSP declaration
keymap.set('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>') -- LSP implementation
keymap.set('n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>') -- LSP type definition
keymap.set('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>') -- LSP references
keymap.set('n', '<leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>') -- LSP signature help
keymap.set('n', '<leader>rr', '<cmd>lua vim.lsp.buf.rename()<CR>') -- LSP rename
keymap.set('n', '<leader>gf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>') -- LSP format
keymap.set('v', '<leader>gf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>') -- LSP format in visual mode
keymap.set('n', '<leader>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>') -- LSP code action
keymap.set('n', '<leader>gl', '<cmd>lua vim.diagnostic.open_float()<CR>') -- LSP diagnostic float
keymap.set('n', '<leader>gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>') -- LSP diagnostic previous
keymap.set('n', '<leader>gn', '<cmd>lua vim.diagnostic.goto_next()<CR>') -- LSP diagnostic next
keymap.set('n', '<leader>tr', '<cmd>lua vim.lsp.buf.document_symbol()<CR>') -- LSP document symbol
keymap.set('i', '<C-Space>', '<cmd>lua vim.lsp.buf.completion()<CR>') -- LSP completion

-- Filetype-specific keymaps (these can be done in the ftplugin directory instead if you prefer)
keymap.set("n", '<leader>go', function()
  if vim.bo.filetype == 'python' then
    vim.api.nvim_command('PyrightOrganizeImports') -- organize imports in Python files
  end
end)

keymap.set("n", '<leader>tc', function()
  if vim.bo.filetype == 'python' then
    require('dap-python').test_class() -- test class in Python files
  end
end)

keymap.set("n", '<leader>tm', function()
  if vim.bo.filetype == 'python' then
    require('dap-python').test_method() -- test method in Python files
  end
end)

-- Debugging
keymap.set("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>") -- toggle breakpoint
keymap.set("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>") -- set conditional breakpoint
keymap.set("n", "<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>") -- set logpoint
keymap.set("n", '<leader>br', "<cmd>lua require'dap'.clear_breakpoints()<cr>") -- clear breakpoints
keymap.set("n", '<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>') -- list breakpoints
keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>") -- continue debugging
keymap.set("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>") -- step over
keymap.set("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>") -- step into
keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>") -- step out
keymap.set("n", '<leader>dd', function() require('dap').disconnect(); require('dapui').close(); end) -- disconnect and close UI
keymap.set("n", '<leader>dt', function() require('dap').terminate(); require('dapui').close(); end) -- terminate and close UI
keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>") -- toggle REPL
keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>") -- run last debugging session
keymap.set("n", '<leader>di', function() require "dap.ui.widgets".hover() end) -- hover to inspect
keymap.set("n", '<leader>d?', function() local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes) end) -- show scopes
keymap.set("n", '<leader>df', '<cmd>Telescope dap frames<cr>') -- list frames
keymap.set("n", '<leader>dh', '<cmd>Telescope dap commands<cr>') -- list commands
keymap.set("n", '<leader>de', function() require('telescope.builtin').diagnostics({default_text=":E:"}) end) -- search diagnostics
