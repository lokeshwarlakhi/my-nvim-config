-- Indentation guides
-- This plugin adds indentation guides to Neovim. It uses Neovim's virtual text feature and no conceal
return {
  -- https://github.com/lukas-reineke/indent-blankline.nvim
  "lukas-reineke/indent-blankline.nvim",
  event = 'VeryLazy',
  main = "ibl",
  opts = {
    enabled = true,
    indent = {
      char = '|',
    },
  },
}
