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
		},
		filesystem = {
			filtered_items = {
				visible = false, -- when true, they will just be displayed differently than normal items
				hide_dotfiles = false,
				hide_gitignored = true,
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
				},
			},
		},
	},
}
