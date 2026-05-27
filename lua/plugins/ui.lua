-- ============================================================================
-- VISUAL UI COMPONENTS (THEME, STATUSLINE, TABLINE, OUTLINE, TODO COMMENTS)
-- ============================================================================
-- Purpose: Unified user interface settings to style Neovim like a premium IDE.
-- ============================================================================

return {
  -- Unified Nerd Font Devicons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
  
  -- Colorscheme (Shatur/neovim-ayu)
  {
    "Shatur/neovim-ayu",
    lazy = false,
    priority = 1000,
    config = function()
      local settings = require("config.settings")
      require("ayu").setup({
        mirage = true, -- Set to true to use the Mirage variant
        terminal = true,
      })
      local colorscheme = settings.get("ui.colorscheme", "ayu-mirage")
      vim.cmd("colorscheme " .. colorscheme)
    end
  },
  
  -- Lualine (Status bar)
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      local settings = require("config.settings")
      local border_style = settings.get("ui.border", "rounded")
      
      return {
        options = {
          theme = "auto",
          component_separators = { left = "│", right = "│" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = { "neo-tree", "Outline" },
          },
        },
        sections = {
          lualine_a = { { "mode", separator = { left = "", right = "" }, right_padding = 2 } },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { { "location", separator = { left = "", right = "" }, left_padding = 2 } },
        }
      }
    end
  },
  
  -- Bufferline (Buffer tabs)
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        mode = "buffers",
        separator_style = "slant",
        show_close_icon = false,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and "✗ " or "⚠ "
          return " " .. icon .. count
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            text_align = "left",
            separator = true,
          }
        }
      }
    }
  },
  
  -- Aerial (Symbols Outline & Code Breadcrumbs)
  {
    "stevearc/aerial.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    keys = {
      { "<leader>o", "<cmd>AerialToggle! left<CR>", desc = "Toggle symbols outline" },
    },
    config = function()
      require("aerial").setup({
        on_attach = function(bufnr)
          -- Jump forwards/backwards with standard mappings inside aerial
          vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
          vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
        layout = {
          min_width = 30,
          default_direction = "left",
        },
        show_guides = true,
      })
    end
  },
  
  -- Todo Comments (Tracker & Highlighter)
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup({
        signs = true,
        keywords = {
          FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        }
      })
      -- Find all TODO comments using Telescope helper
      vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find TODOs in project" })
    end
  },

  -- Smooth Scrolling (neoscroll.nvim)
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = function()
      vim.opt.mouse = 'a'  -- enable mouse scrolling inside Neovim
      require("neoscroll").setup({
        mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
        hide_cursor = true,
        stop_eof = true,
        respect_scrolloff = false,
        cursor_scrolls_alone = true,
        easing_function = "quadratic",
      })
    end
  }
}
