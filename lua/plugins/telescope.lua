--[[
TELESCOPE:
==============
Telescope is a powerful fuzzy finder for files, buffers, search results, etc.
]]
return { -- Returms a Table containing the plugin specification for Telescope
  'nvim-telescope/telescope.nvim', -- "Plugin identifier"
  lazy = true, --[[Lazy loading mode: Explicitly enables lazy loading
- Telescope won't load at startup, only when needed
- This speeds up Neovim startup time
  ]]
  dependencies = {
    { 'nvim-lua/plenary.nvim' }, --[[Plenary: A utility library that Telescope depends on
Provides common Lua functions for async operations, etc.
Essential for Telescope to function]]
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },--[[telescope-fzf-native.nvim: Native C binary for faster fuzzy search
build = 'make': Runs make command after downloading to compile the binary

cond = function(): Conditional installation
  - vim.fn.executable 'make': Checks if the make command is available on your system
  - == 1: Returns true if available, false if not
  - Purpose: Only installs fzf extension if make is available (macOS/Linux)
  - On Windows without make, Lazy skips this extension]]
  },--[[Plugin dependencies: Lists other plugins that must be installed for Telescope to work]]

  opts = {
    defaults = {
      layout_config = {
        vertical = {
          width = 0.75
        }
      },
      path_display = {
        filename_first = {
          reverse_directories = true
        }
      },
    }
  },
  config = function(_, opts)
    local telescope = require('telescope')
    telescope.setup(opts)
    
    -- Load extensions
    pcall(telescope.load_extension, 'fzf')
  end,
}
