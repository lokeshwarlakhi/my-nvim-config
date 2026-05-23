return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    ensure_installed = { "lua", "python", "javascript" },
    highlight = { enable = true },
    indent = { enable = true }
  }
}
