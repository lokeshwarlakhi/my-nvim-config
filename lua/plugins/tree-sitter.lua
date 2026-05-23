-- ============================================================================
-- TREESITTER (SYNTAX HIGHLIGHTING & PARSING)
-- ============================================================================
-- Purpose: Premium syntax highlighting, code indentation, and smart folding.
-- ============================================================================

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main", -- Required for Neovim 0.12+ compatibility
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local ts = require("nvim-treesitter")
      ts.setup({
        -- Use standard installation path
        install_dir = vim.fn.stdpath('data') .. '/site'
      })

      -- Supported languages
      local languages = {
        "lua",
        "python",
        "go",
        "rust",
        "javascript",
        "typescript",
        "tsx",
        "bash",
        "yaml",
        "json",
        "markdown",
        "markdown_inline",
        "dockerfile",
        "terraform",
        "sql",
      }

      -- Install languages asynchronously (no-op if already installed)
      ts.install(languages)

      -- Enable highlighting and experimental indentation for these languages
      vim.api.nvim_create_autocmd("FileType", {
        pattern = languages,
        callback = function()
          pcall(vim.treesitter.start)
          pcall(function()
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end)
        end,
      })
    end
  }
}
