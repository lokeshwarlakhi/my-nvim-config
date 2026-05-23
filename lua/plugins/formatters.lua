-- ============================================================================
-- FORMATTING (CONFORM.NVIM)
-- ============================================================================
-- Purpose: Code formatting with dynamic settings loaded from language specifications.
-- ============================================================================

return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = { "ConformInfo", "Format" },
    config = function()
      local settings = require("config.settings")
      local lang_orchestrator = require("languages")
      
      local format_opts = {
        formatters_by_ft = lang_orchestrator.formatters_by_ft or {},
        formatters = lang_orchestrator.formatters or {},
      }
      
      -- Load format on save if enabled globally
      if settings.get("formatting.format_on_save", true) then
        format_opts.format_on_save = {
          timeout_ms = settings.get("formatting.timeout_ms", 5000),
          lsp_fallback = settings.get("formatting.lsp_fallback", true),
        }
      end
      
      require("conform").setup(format_opts)
      
      -- Manual format command
      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        require("conform").format({
          async = true,
          lsp_fallback = settings.get("formatting.lsp_fallback", true),
          range = range,
        })
      end, { range = true })
      
      -- Verbose diagnostic format command
      vim.api.nvim_create_user_command("FormatVerbose", function()
        require("conform").format({
          timeout_ms = 10000,
          lsp_fallback = true,
          quiet = false,
        })
      end, {})
      
      -- Keymap for manual formatting
      vim.keymap.set({ "n", "v" }, "<leader>lf", "<cmd>Format<CR>", { desc = "Format document" })
    end
  }
}
