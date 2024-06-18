-- Theme/Colorscheme (uncomment section for whichever theme you prefer or use your own)
-- Kanagawa Theme (Custom Palette)
-- return {
--   -- https://github.com/rebelot/kanagawa.nvim
--   'rebelot/kanagawa.nvim', -- You can replace this with your favorite colorscheme
--   lazy = false, -- We want the colorscheme to load immediately when starting Neovim
--   priority = 1000, -- Load the colorscheme before other non-lazy-loaded plugins
--   opts = {
--     -- Replace this with your scheme-specific settings or remove to use the defaults
--     -- transparent = true,
--     background = {
--       -- light = "lotus",
--       dark = "wave", -- "wave, dragon"
--     },
--     colors = {
--       palette = {
--         -- Background colors
--         sumiInk0 = "#161616", -- modified
--         sumiInk1 = "#181818", -- modified
--         sumiInk2 = "#1a1a1a", -- modified
--         sumiInk3 = "#1F1F1F", -- modified
--         sumiInk4 = "#2A2A2A", -- modified
--         sumiInk5 = "#363636", -- modified
--         sumiInk6 = "#545454", -- modified

--         -- Popup and Floats
--         waveBlue1 = "#322C47", -- modified
--         waveBlue2 = "#4c4464", -- modified

--         -- Diff and Git
--         winterGreen = "#2B3328",
--         winterYellow = "#49443C",
--         winterRed = "#43242B",
--         winterBlue = "#252535",
--         autumnGreen = "#76A56A", -- modified
--         autumnRed = "#C34043",
--         autumnYellow = "#DCA561",

--         -- Diag
--         samuraiRed = "#E82424",
--         roninYellow = "#FF9E3B",
--         waveAqua1 = "#7E9CD8", -- modified
--         dragonBlue = "#7FB4CA", -- modified

--         -- Foreground and Comments
--         oldWhite = "#C8C093",
--         fujiWhite = "#F9E7C0", -- modified
--         fujiGray = "#727169",
--         oniViolet = "#BFA3E6", -- modified
--         oniViolet2 = "#BCACDB", -- modified
--         crystalBlue = "#8CABFF", -- modified
--         springViolet1 = "#938AA9",
--         springViolet2 = "#9CABCA",
--         springBlue = "#7FC4EF", -- modified
--         waveAqua2 = "#77BBDD", -- modified

--         springGreen = "#98BB6C",
--         boatYellow1 = "#938056",
--         boatYellow2 = "#C0A36E",
--         carpYellow = "#FFEE99", -- modified

--         sakuraPink = "#D27E99",
--         waveRed = "#E46876",
--         peachRed = "#FF5D62",
--         surimiOrange = "#FFAA44", -- modified
--         katanaGray = "#717C7C",
--       },
--     },
--   },
--   config = function(_, opts)
--     require('kanagawa').setup(opts) -- Replace this with your favorite colorscheme
--     vim.cmd("colorscheme kanagawa") -- Replace this with your favorite colorscheme

--     -- Custom diff colors
--     vim.cmd([[
--       autocmd VimEnter * hi DiffAdd guifg=#00FF00 guibg=#005500
--       autocmd VimEnter * hi DiffDelete guifg=#FF0000 guibg=#550000
--       autocmd VimEnter * hi DiffChange guifg=#CCCCCC guibg=#555555
--       autocmd VimEnter * hi DiffText guifg=#00FF00 guibg=#005500
--     ]])

--     -- Custom border colors
--     vim.cmd([[
--       autocmd ColorScheme * hi NormalFloat guifg=#F9E7C0 guibg=#1F1F1F
--       autocmd ColorScheme * hi FloatBorder guifg=#F9E7C0 guibg=#1F1F1F
--     ]])
--   end
-- }

-- Kanagawa Theme (Original)
-- return {
--   -- https://github.com/rebelot/kanagawa.nvim
--   'rebelot/kanagawa.nvim', -- You can replace this with your favorite colorscheme
--   lazy = false, -- We want the colorscheme to load immediately when starting Neovim
--   priority = 1000, -- Load the colorscheme before other non-lazy-loaded plugins
--   opts = {
--     -- Replace this with your scheme-specific settings or remove to use the defaults
--     -- transparent = true,
--     background = {
--       -- light = "lotus",
--       dark = "wave", -- "wave, dragon"
--     },
--   },
--   config = function(_, opts)
--     require('kanagawa').setup(opts) -- Replace this with your favorite colorscheme
--     vim.cmd("colorscheme kanagawa") -- Replace this with your favorite colorscheme
--   end
-- }

-- Tokyo Night Theme
-- return {
--   -- https://github.com/folke/tokyonight.nvim
--   'folke/tokyonight.nvim', -- You can replace this with your favorite colorscheme
--   lazy = false, -- We want the colorscheme to load immediately when starting Neovim
--   priority = 1000, -- Load the colorscheme before other non-lazy-loaded plugins
--   opts = {
--     -- Replace this with your scheme-specific settings or remove to use the defaults
--     -- transparent = true,
--     style = "night", -- other variations "storm, night, moon, day"
--   },
--   config = function(_, opts)
--     require('tokyonight').setup(opts) -- Replace this with your favorite colorscheme
--     vim.cmd("colorscheme tokyonight") -- Replace this with your favorite colorscheme
--   end
-- }

-- Catppuccin Theme
return {
-- https://github.com/catppuccin/nvim
'catppuccin/nvim',
name = "catppuccin", -- name is needed otherwise plugin shows up as "nvim" due to github URI
lazy = false, -- We want the colorscheme to load immediately when starting Neovim
priority = 1000, -- Load the colorscheme before other non-lazy-loaded plugins
opts = {
--   -- Replace this with your scheme-specific settings or remove to use the defaults
-- transparent = true,
flavour = "mocha", -- "latte, frappe, macchiato, mocha"
},
config = function(_, opts)
require('catppuccin').setup(opts) -- Replace this with your favorite colorscheme
vim.cmd("colorscheme catppuccin") -- Replace this with your favorite colorscheme
end
}


-- 
-- Sonokai Theme
-- return {
--   -- https://github.com/sainnhe/sonokai
--  'sainnhe/sonokai',
--   lazy = false, -- We want the colorscheme to load immediately when starting Neovim
--   priority = 1000, -- Load the colorscheme before other non-lazy-loaded plugins
--   config = function(_, opts)
--     vim.g.sonokai_style = "default" -- "default, atlantis, andromeda, shusia, maia, espresso"
--     vim.cmd("colorscheme sonokai") -- Replace this with your favorite colorscheme
--   end
-- },

-- One Nord Theme
 -- return {
 --   -- https://github.com/rmehri01/onenord.nvim
 --   'rmehri01/onenord.nvim',
 --   lazy = false, -- We want the colorscheme to load immediately when starting Neovim
 --   priority = 1000, -- Load the colorscheme before other non-lazy-loaded plugins
 --   config = function(_, opts)
 --     vim.cmd("colorscheme onenord") -- Replace this with your favorite colorscheme
 --   end
 -- }
 


-- -- One monokai theme
-- return {
--   "cpea2506/one_monokai.nvim",
--     lazy = false, -- We want the colorscheme to load immediately when starting Neovim
--     priority = 1000, -- Load the colorscheme before other non-lazy-loaded plugins
--     config = function(_, opts)
--       require("one_monokai").setup({
--       transparent = false,
--       colors = {},
--       themes = function(colors)
--           return {}
--       end,
--       italics = true,
--     })
--        end
--  }

-- One Dark theme

-- return {
--   'navarasu/onedark.nvim',
--     lazy = false, -- We want the colorscheme to load immediately when starting Neovim
--     priority = 1000, -- Load the colorscheme before other non-lazy-loaded plugins
--     config = function(_, opts)
--       require('onedark').setup {
--         -- Main options --
--         style = 'darker', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
--         transparent = false,  -- Show/hide background
--         term_colors = true, -- Change terminal color as per the selected theme style
--         ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
--         cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

--         -- toggle theme style ---
--         toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
--         toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

--         -- Change code style ---
--         -- Options are italic, bold, underline, none
--         -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
--         code_style = {
--             comments = 'italic',
--             keywords = 'none',
--             functions = 'none',
--             strings = 'none',
--             variables = 'none'
--         },

--         -- Lualine options --
--         lualine = {
--             transparent = false, -- lualine center bar transparency
--         },

--         -- Custom Highlights --
--         colors = {}, -- Override default colors
--         highlights = {}, -- Override highlight groups

--         -- Plugins Config --
--         diagnostics = {
--             darker = true, -- darker colors for diagnostic
--             undercurl = true,   -- use undercurl instead of underline for diagnostics
--             background = true,    -- use background color for virtual text
--         },
--       }

--       -- Apply the Onedark colorscheme
--       require('onedark').load()
--     end
--   }

-- Bluloco Theme
-- return {
--   -- https://github.com/uloco/bluloco.nvim 
--   'uloco/bluloco.nvim',
--   lazy = false,
--   priority = 1000,
--   dependencies = { 'rktjmp/lush.nvim' },
--   config = function(_,opts)
--     vim.cmd("colorscheme bluloco")
--   end,
-- }
