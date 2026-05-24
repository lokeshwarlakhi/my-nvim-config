return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	cmd = "Neotree",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<leader>e", ":Neotree toggle<CR>", desc = "Toggle Explorer" },
		{ "<leader>zc", function() require("neo-tree.command").execute({ action = "close_all_nodes" }) end, desc = "Collapse all folders" },
	},
	opts = {
		default_source = "filesystem",
		use_popups = false,
		enable_last_close = true,
		close_if_last_window = true,
		popup_border_style = "rounded",
		enable_git_status = true,
		enable_diagnostics = true,
		default_component_configs = {
			indent = {
				with_expanders = true, -- if nil and file nesting is enabled, enables expanders
				expander_collapsed = "→",
				expander_expanded = "↓",
				expander_highlight = "NeoTreeExpander",
			},
			git_status = {
				symbols = {
					added     = "",
					deleted   = "",
					modified  = "M",
					renamed   = "",
					untracked = "U",
					ignored   = "",
					unstaged  = "",
					staged    = "",
					conflict  = "",
				},
			},
		},
		filesystem = {
			filtered_items = {
				visible = false, -- when true, they will just be displayed differently than normal items
				hide_dotfiles = false,
				hide_gitignored = false,
			},
			follow_current_file = {
				enabled = true, -- This will find and focus the file in the active buffer every time
			},
			window = {
				width = 26,
				mappings = {
					["<bs>"] = "navigate_up",
					["."] = "set_root",
					["H"] = "toggle_hidden",
					["<Esc>"] = "clear_filter",  -- press Esc to cancel the find dialog / clear filter
					["zc"] = "close_all_nodes",  -- collapse all folders (inside Neo‑tree)
				},
			},
		},
	},
	config = function(_, opts)
		require("neo-tree").setup(opts)

		-- Apply bold styling to Neo-tree Git status highlight groups
		local function apply_bold_git_highlights()
			for _, group in ipairs({ "NeoTreeGitModified", "NeoTreeGitUntracked" }) do
				local hl = vim.api.nvim_get_hl(0, { name = group })
				hl.bold = true
				vim.api.nvim_set_hl(0, group, hl)
			end
		end

		vim.api.nvim_create_autocmd("ColorScheme", {
			callback = apply_bold_git_highlights,
		})

		apply_bold_git_highlights()
	end,
}
