-- ============================================================================
-- DEBUGGER (DAP - DEBUG ADAPTER PROTOCOL)
-- ============================================================================
-- Purpose: IDE-grade debugger configuration with full variable inspector,
--          watch expressions, call stack, and inline virtual text.
--          Adapters and run configurations are loaded from language modules.
-- ============================================================================

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio", -- Required for dap-ui
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Debug: Continue" },
      { "<leader>ds", function() require("dap").step_over() end, desc = "Debug: Step over" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Debug: Step into" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Debug: Step out" },
      { "<leader>dr", function() require("dap").restart() end, desc = "Debug: Restart" },
      { "<leader>dq", function() require("dap").terminate() end, desc = "Debug: Terminate session" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Debug: Toggle debugger UI" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local lang_orchestrator = require("languages")
      local settings = require("config.settings")
      
      -- Initialize DAP UI
      dapui.setup({
        controls = {
          enabled = settings.get("debugging.ui.controls_enabled", true),
          element = "repl",
        },
        floating = { border = "rounded" },
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            position = "left",
            size = 40,
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            position = "bottom",
            size = 10,
          },
        },
      })
      
      -- Initialize Virtual Text (inline variable evaluations)
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        display_callback = function(variable, buf, stackframe, node, options)
          if options.virt_text_pos == 'inline' then
            return ' = ' .. variable.value
          else
            return variable.name .. ' = ' .. variable.value
          end
        end,
      })
      
      -- Open/close DAP UI automatically on session events
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
      
      -- Register debugging icons
      local bp_icon = settings.get("debugging.breakpoints.breakpoint_text", "●")
      local lp_icon = settings.get("debugging.breakpoints.logpoint_text", "◆")
      vim.fn.sign_define("DapBreakpoint", { text = bp_icon, texthl = "DiagnosticError", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = bp_icon, texthl = "DiagnosticWarn", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = lp_icon, texthl = "DiagnosticInfo", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "➜", texthl = "DiagnosticHint", linehl = "Visual", numhl = "Visual" })
      
      -- Register adapters and configurations dynamically from language orchestrator
      if lang_orchestrator.dap_adapters then
        for name, adapter in pairs(lang_orchestrator.dap_adapters) do
          dap.adapters[name] = adapter
        end
      end
      
      if lang_orchestrator.dap_configurations then
        for ft, configs in pairs(lang_orchestrator.dap_configurations) do
          dap.configurations[ft] = configs
        end
      end
    end
  }
}
