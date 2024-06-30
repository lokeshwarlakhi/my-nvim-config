-- File Explorer / Tree
-- return {
--   -- https://github.com/nvim-tree/nvim-tree.lua
--   'nvim-tree/nvim-tree.lua',
--   dependencies = {
--     -- https://github.com/nvim-tree/nvim-web-devicons
--     'nvim-tree/nvim-web-devicons', -- Fancy icon support
--     "nvim-lua/plenary.nvim",
--     "MunifTanjim/nui.nvim",
--   },
--   opts = {
--     filters={
--       git_ignored=false
--     },
--     actions = {
--       open_file = {
--         window_picker = {
--           enable = false
--         },
--       }
--     },
--   },
--   config = function (_, opts)
--     -- Recommended settings to disable default netrw file explorer
--     vim.g.loaded_netrw = 1
--     vim.g.loaded_netrwPlugin = 1
--     require("nvim-tree").setup(opts)
--   end
-- }



return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      git_status = {
        symbols = {
          -- Change type
          added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
          deleted   = "✖", -- this can only be used in the git_status source
          renamed   = "󰁕", -- this can only be used in the git_status source
          -- Status type
          untracked = "",
          ignored   = "",
          unstaged  = "󰄱",
          staged    = "",
          conflict  = "",
        }

      },
      filesystem = {
          filtered_items = {
            visible = true, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = falsee,
            hide_gitignored = false,
            hide_hidden = true, -- only works on Windows for hidden files/directories
            hide_by_name = {
              --"node_modules"
            },
        },
      },
   window = {
          position = "left",
          width = 34,
      },
    })
  end

}
