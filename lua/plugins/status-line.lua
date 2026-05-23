return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = "nvim-web-devicons",
  opts = {
    options = {
      theme = "auto",
      component_separators = "|",
      section_separators = "",
    }
  }
}

--[[
why didn't we write any config variable for this file?
-------------------------------------------------------
Lazy.nvim has a smart default behavior. When you provide opts without a config function, Lazy.nvim automatically does this:
require("plugin-name").setup(opts)

So this:
return {
  "nvim-lualine/lualine.nvim",
  opts = { ... }
}

is effectively the same as:
return {
  "nvim-lualine/lualine.nvim",
  opts = { ... },
  config = function(_, opts)
    require("lualine").setup(opts)
  end
}

Why Your mason.lua Has a Config Function
-------------------------------------------------------
This is actually redundant. Lazy would do it automatically! You could simplify it to just opts = { ... } without the explicit config function.

When You NEED a Config Function
-------------------------------
Only use config when you need custom logic:
config = function(_, opts)
  require("lualine").setup(opts)
  
  -- Additional setup after initialization
  vim.cmd("colorscheme gruvbox")
  
  -- Multiple setup calls
  require("other-module").setup()
end
]]