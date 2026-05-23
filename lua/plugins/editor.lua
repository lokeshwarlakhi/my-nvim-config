-- ============================================================================
-- EDITOR UTILITIES (COMMENTING, AUTOPAIRS, SURROUND, MULTICURSOR)
-- ============================================================================
-- Purpose: Visual helper plugins to improve text manipulation and speed.
-- ============================================================================

return {
  -- Comments (gcc / gc)
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("Comment").setup()
    end
  },
  
  -- Autopairs (automatic brackets pairing)
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true, -- Enable Treesitter checking
        ts_config = {
          lua = { "string" }, -- Don't add pairs inside lua string treesitter nodes
          javascript = { "template_string" },
        }
      })
      
      -- Auto-insert brackets on completion confirm
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp_ok, cmp = pcall(require, "cmp")
      if cmp_ok then
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end
    end
  },
  
  -- Surround (ysw", ds", cs"")
  {
    "kylechui/nvim-surround",
    version = "*", -- Use latest release
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-surround").setup({})
    end
  },
  
  -- Multicursor Support (vim-visual-multi)
  -- Standard VSCode-like multi cursor bindings:
  -- - Ctrl-N: Select word under cursor, press Ctrl-N again to select next instance.
  -- - Alt-Click or key bindings to add cursors up/down.
  {
    "mg979/vim-visual-multi",
    event = { "BufReadPost", "BufNewFile" },
    init = function()
      -- Configure visual multi variables before load
      vim.g.VM_maps = {
        ["Find Under"] = "<C-d>", -- Matches VSCode C-d
        ["Find Subword Under"] = "<C-d>",
      }
    end
  }
}
