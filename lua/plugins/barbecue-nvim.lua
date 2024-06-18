-- Display LSP-based breadcrumbs
--breadcrumbs refer to a navigational aid typically displayed at the top of a page or interface. They show the user's current location within a hierarchical structure and provide links to higher-level pages or categories. Breadcrumbs are especially useful in applications with deep or nested content structures, such as websites with multiple layers of navigation or file systems with directories within directories.
return {
  -- https://github.com/utilyre/barbecue.nvim
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  dependencies = {
  -- https://github.com/SmiteshP/nvim-navic
    "SmiteshP/nvim-navic",
  -- https://github.com/nvim-tree/nvim-web-devicons
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  opts = {
    -- configurations go here
  },
}
