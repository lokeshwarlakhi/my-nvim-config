-- ============================================================================
-- LINTING (NVIM-LINT)
-- ============================================================================
-- Purpose: Static analysis with configurations loaded from language specifications.
-- ============================================================================

return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost", "BufEnter" },
    config = function()
      local settings = require("config.settings")
      local lang_orchestrator = require("languages")
      local lint = require("lint")
      
      -- Load dynamic linters from orchestrator
      lint.linters_by_ft = lang_orchestrator.linters_by_ft or {}
      
      -- Register custom linter configurations
      if lang_orchestrator.linters then
        for name, config in pairs(lang_orchestrator.linters) do
          lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name] or {}, config)
        end
      end
      
      -- Trigger linting
      local function try_lint()
        -- Skip disabled linters globally or per project
        local disabled = settings.get("linting.disabled_linters", {})
        local active_linters = lint.linters_by_ft[vim.bo.filetype] or {}
        
        if #active_linters == 0 then
          return
        end
        
        -- Filter out disabled linters
        local filtered = {}
        for _, linter in ipairs(active_linters) do
          if not vim.tbl_contains(disabled, linter) then
            table.insert(filtered, linter)
          end
        end
        
        if #filtered > 0 then
          lint.try_lint(filtered)
        end
      end
      
      -- Setup autocommands to run linter
      local group = vim.api.nvim_create_augroup("NvimLintTrigger", { clear = true })
      
      if settings.get("linting.lint_on_enter", true) then
        vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPost" }, {
          group = group,
          callback = try_lint,
        })
      end
      
      if settings.get("linting.lint_on_save", true) then
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
          group = group,
          callback = try_lint,
        })
      end
      
      -- Manual lint command
      vim.api.nvim_create_user_command("Lint", try_lint, {})
    end
  }
}
