-- ============================================================================
-- INTERACTIVE PYTHON (MOLTEN-NVIM & IMAGE RENDERING)
-- ============================================================================
-- Purpose: Setup Jupyter notebook-like execution and inline pyplot/matplotlib 
--          visualizations inside Neovim.
-- ============================================================================

return {
  -- Luarocks integration for Lua dependencies (e.g. magick rock for image.nvim)
  {
    "vhyrro/luarocks.nvim",
    priority = 1001, -- Load extremely early
    opts = {
      rocks = { "magick" },
    },
  },

  -- Image rendering engine
  {
    "3rd/image.nvim",
    dependencies = { "vhyrro/luarocks.nvim" },
    event = "VeryLazy",
    config = function()
      require("image").setup({
        backend = "kitty", -- Default to Kitty graphics protocol, falls back automatically
        max_height_window_percentage = 50,
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.svg" },
      })
    end,
  },

  -- Molten Interactive Jupyter Client
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- Avoid breaking changes
    build = ":UpdateRemotePlugins",
    dependencies = { "3rd/image.nvim" },
    ft = { "python" }, -- Only load when editing Python files
    init = function()
      -- Tell molten to use image.nvim to render images/plots
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      
      -- Recommended settings for premium visual flow
      vim.g.molten_auto_open_output = false
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
    end,
    config = function()
      local keymap = vim.keymap.set
      
      -- Initialize kernel (starts jupyter/ipython connection)
      keymap("n", "<leader>mi", ":MoltenInit<CR>", { desc = "Initialize Molten Kernel", silent = true })
      
      -- Code execution
      keymap("n", "<leader>me", ":MoltenEvaluateOperator<CR>", { desc = "Evaluate operator/motion", silent = true })
      keymap("n", "<leader>ml", ":MoltenEvaluateLine<CR>", { desc = "Evaluate current line", silent = true })
      keymap("v", "<leader>mv", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "Evaluate visual selection", silent = true })
      
      -- Kernel management
      keymap("n", "<leader>mr", ":MoltenRestart<CR>", { desc = "Restart Molten Kernel", silent = true })
      keymap("n", "<leader>mk", ":MoltenInterrupt<CR>", { desc = "Interrupt Molten Kernel", silent = true })
      
      -- Output window controls
      keymap("n", "<leader>mh", ":MoltenHideOutput<CR>", { desc = "Hide Molten Output", silent = true })
      keymap("n", "<leader>ms", ":MoltenShowOutput<CR>", { desc = "Show Molten Output", silent = true })
    end,
  },
}
