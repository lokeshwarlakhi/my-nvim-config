return { --[[ Returns a Lua table that Lazy.nvim will read as a plugin specification
Every Lazy.nvim plugin config must return a table
]]
  "williamboman/mason.nvim", --[[ Plugin identifier: Tells Lazy.nvim which plugin to install
  -- Format: "github_username/repo_name"
  ]] 
  cmd = "Mason", --[[Lazy loading trigger: Only loads Mason when you run the :Mason command
  - This speeds up Neovim startup since Mason isn't needed right away
  - Alternative loaders: event (on events), keys (on key presses), ft (on filetypes)
  ]]
  opts = { --[[Options table: Defines configuration passed to Mason's setup() function
  - Lazy.nvim automatically passes this to the plugin's config function
  ]]
    ui = { --[[UI section: Customizes the visual appearance of Mason's interface 
    ]]
      border = "rounded", --[[Other options: "solid", "double", "shadow", "none"]]
      icons = {
        package_installed = "✓", -- Checkmark for installed packages
        package_pending = "➜", -- Arrow for pending installations
        package_uninstalled = "✗" -- X mark for uninstalled packages
      }
    }
  },
  config = function(_, opts)
    require("mason").setup(opts)
  end --[[ Called after Mason is loaded
_ = placeholder (unused) parameter (the plugin spec)
opts = the options table defined above
require("mason") loads the Mason module
.setup(opts) initializes Mason with the configuration options
  ]]
}
