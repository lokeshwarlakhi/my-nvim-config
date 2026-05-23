-- ============================================================================
-- VERSION CONTROL SYSTEM (GIT INTEGRATIONS)
-- ============================================================================
-- Purpose: Gutter highlights for changes, inline git blame, and side-by-side
--          diff review panels.
-- ============================================================================

local settings = require("config.settings")

return {
  -- Gitsigns (gutter decorations & inline blame)
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    enabled = settings.get("git.enable_gitsigns", true),
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = "┃" },
          change       = { text = "┃" },
          delete       = { text = "_" },
          topdelete    = { text = "‾" },
          changedelete = { text = "~" },
          untracked    = { text = "┆" },
        },
        current_line_blame = true, -- Inline git blame comments
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol", -- End of line
          delay = 500,
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end
          
          -- Hunk navigation
          map("n", "]h", function()
            if vim.wo.diff then return "]h" end
            vim.schedule(function() gs.next_hunk() end)
            return "<Ignore>"
          end, { expr = true, desc = "Git: Next hunk" })
          
          map("n", "[h", function()
            if vim.wo.diff then return "[h" end
            vim.schedule(function() gs.prev_hunk() end)
            return "<Ignore>"
          end, { expr = true, desc = "Git: Previous hunk" })
          
          -- Actions
          map("n", "<leader>hs", gs.stage_hunk, { desc = "Git: Stage hunk" })
          map("n", "<leader>hr", gs.reset_hunk, { desc = "Git: Reset hunk" })
          map("n", "<leader>hp", gs.preview_hunk, { desc = "Git: Preview hunk" })
          map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { desc = "Git: Blame current line" })
        end
      })
    end
  },
  
  -- Diffview (graphical side-by-side git diff tool)
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    enabled = settings.get("git.enable_diffview", true),
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Git: Open diff review panel" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "Git: Show current file history" },
    },
    opts = {
      enhanced_diff_hl = true,
      hooks = {},
      keymaps = {
        view = {
          { "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close Diffview" } }
        },
        file_panel = {
          { "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close Diffview" } }
        }
      }
    }
  }
}
