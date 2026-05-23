return {
  "akinsho/toggleterm.nvim",
  cmd = "ToggleTerm",
  keys = {
    { "<leader>t", ":ToggleTerm<CR>" }
  },
  opts = {
    open_mapping = [[<c-\>]],
    direction = "float"
  }
}
