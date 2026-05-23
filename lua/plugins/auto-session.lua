return {
	"rmagatti/auto-session",
	lazy = false,
	opts = {
		auto_restore = true,
		auto_save = true,
		-- Prevents sessions from being created in home or root
		suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
		bypass_save_filetypes = { "neo-tree", "terminal" },
		pre_save_cmds = {
			function() require("neo-tree.command").execute({ action = "close" }) end
		},
		pre_restore_cmds = {
			function() vim.cmd("Neotree close") end
		},
	},
}
