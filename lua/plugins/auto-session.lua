return {
	"rmagatti/auto-session",
	lazy = false,
	opts = {
		auto_restore_enabled = true,
		auto_save_enabled = true,
		-- Prevents sessions from being created in home or root
		suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
		bypass_session_save_file_types = { "neo-tree", "terminal" },
		pre_save_cmds = {
			function() require("neo-tree.command").execute({ action = "close" }) end
		},
		pre_restore_cmds = {
			function() vim.cmd("Neotree close") end
		},
	},
}
