-- ============================================================================
-- PYTHON VIRTUALENV SELECTOR (VENV-SELECTOR-NVIM)
-- ============================================================================
-- Purpose: Interactively search and activate virtual environments within Neovim.
--          Automatically updates Pyright to resolve imports.
-- ============================================================================

return {
  {
    "linux-cultist/venv-selector.nvim",

    lazy = true,
    event = "VeryLazy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    opts = {
      name = { "venv", ".venv" },
      auto_refresh = true,
    },
    keys = {
      { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select Virtual Environment" },
    },
  }
}
