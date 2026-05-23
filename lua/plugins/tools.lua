-- ============================================================================
-- PRODUCTIVITY WORKSPACE TOOLS
-- ============================================================================
-- Purpose: Terminal manager, code docstring generator, and markdown previewer.
-- ============================================================================

return {
  -- Terminal Manager (ToggleTerm)
  {
    "akinsho/toggleterm.nvim",
    cmd = "ToggleTerm",
    keys = {
      { "<leader>t", "<cmd>ToggleTerm<CR>", desc = "Toggle Terminal Window" }
    },
    opts = {
      size = 20,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_terminals = true,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float", -- Float window
      close_on_exit = true,
      float_opts = {
        border = "rounded",
        winblend = 3,
      }
    }
  },
  
  -- Docstring Generator (Neogen)
  {
    "danymat/neogen",
    cmd = "Neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    keys = {
      { "<leader>nc", "<cmd>Neogen<CR>", desc = "Generate code docstring" }
    },
    opts = {
      enabled = true,
      languages = {
        python = {
          template = {
            annotation_convention = "numpydoc" -- NumPy format standard
          }
        }
      }
    }
  },
  
  -- Markdown Browser Preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && npm install",
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", desc = "Toggle Markdown Preview" }
    }
  },

  -- Render Markdown (rendered markdown UI inside the buffer)
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown" },
    keys = {
      { "<leader>tm", "<cmd>RenderMarkdown toggle<CR>", desc = "Toggle Markdown Rendering" }
    },
    opts = {},
  }
}
