-- ============================================================================
-- TEST RUNNER (NEOTEST)
-- ============================================================================
-- Purpose: Unified test running suite for python (pytest), go, and other engines.
--          Adapters are loaded dynamically from language specifications.
-- ============================================================================

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      -- Add adapters here so lazy knows to download them
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-go",
    },
    keys = {
      { "<leader>tn", function() require("neotest").run.run() end, desc = "Test: Run nearest test" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Test: Run current file" },
      { "<leader>ta", function() require("neotest").run.run(vim.fn.getcwd()) end, desc = "Test: Run entire test suite" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Test: Toggle test summary panel" },
      { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Test: Show test output" },
      { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Test: Watch current file" },
    },
    config = function()
      local neotest = require("neotest")
      local lang_orchestrator = require("languages")
      
      local neotest_adapters = {}
      
      -- Load and configure test adapters from active languages
      if lang_orchestrator.test_adapters then
        for adapter_name, adapter_opts in pairs(lang_orchestrator.test_adapters) do
          local ok, adapter = pcall(require, adapter_name)
          if ok then
            table.insert(neotest_adapters, adapter(adapter_opts))
          else
            -- Map name to repo naming conventions if they differ
            local mapped_name = adapter_name:gsub("-", ".")
            local ok2, adapter2 = pcall(require, mapped_name)
            if ok2 then
              table.insert(neotest_adapters, adapter2(adapter_opts))
            else
              vim.notify("Neotest adapter not found: " .. adapter_name, vim.log.levels.WARN)
            end
          end
        end
      end
      
      neotest.setup({
        adapters = neotest_adapters,
        discovery = {
          enabled = true,
        },
        summary = {
          open = "botright vsplit | vertical resize 40",
        }
      })
    end
  }
}
