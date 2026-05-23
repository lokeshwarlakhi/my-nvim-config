-- return {
--   "ellisonleao/gruvbox.nvim",
--   priority = 1000, -- Load first

--   config = function()
--     require("gruvbox").setup({
--       -- contrast = "medium", -- or "soft", "medium"
--       -- transparent_mode = false,
--       overrides = {
--         SignColumn = { bg = "#1d2021" }, -- Customize as needed
--       }
--     })
--     vim.cmd("colorscheme gruvbox")
--   end
-- }
--
--------------------------------------------------------------------------------
return {
	"projekt0n/github-nvim-theme",
	lazy = false, -- Load immediately
	priority = 1000, -- High priority to load first
	config = function()
		require("github-theme").setup({
			-- Enable transparent background (optional)
		})

		-- Apply the colorscheme
		-- vim.cmd('colorscheme github_light')
		vim.cmd("colorscheme github_dark_colorblind")
	end,
}
--------------------------------------------------------------------------------
-- return {
-- 	"catppuccin/nvim",
-- 	lazy = false, -- Load immediately
-- 	priority = 1000, -- High priority to load first
-- 	config = function()
-- 		require("catppuccin").setup({
-- 			flavour = "latte",
--
-- 			-- Enable transparent background (optional)
-- 		})
--
-- 		-- Apply the colorscheme
-- 		-- vim.cmd('colorscheme github_light')
-- 		vim.cmd("colorscheme catppuccin-nvim")
-- 	end,
-- }
