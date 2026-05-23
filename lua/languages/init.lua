-- ============================================================================
-- CENTRAL LANGUAGE ORCHESTRATOR
-- ============================================================================
-- Purpose: Dynamically load language modules and aggregate configurations for:
--          LSP, Formatting (conform), Linting (nvim-lint), DAP, Neotest, and Mason.
-- ============================================================================

local settings = require("config.settings")
local M = {}

-- Global registries compiled from all modules
M.lsp_servers = {}
M.lsp_configs = {}
M.formatters_by_ft = {}
M.formatters = {}
M.linters_by_ft = {}
M.linters = {}
M.dap_adapters = {}
M.dap_configurations = {}
M.test_adapters = {}
M.tools_to_install = {}

-- Standard tools needed regardless of languages
local base_tools = { "stylua" }
for _, tool in ipairs(base_tools) do
  table.insert(M.tools_to_install, tool)
end

-- Load active language configurations
local enabled_languages = settings.languages or {}

for lang_name, enabled in pairs(enabled_languages) do
  if enabled then
    local ok, lang_spec = pcall(require, "languages." .. lang_name)
    if ok and lang_spec then
      
      -- 1. LSP configuration
      if lang_spec.lsp then
        -- Single LSP server format
        local server_name = lang_spec.lsp.server
        if server_name then
          table.insert(M.lsp_servers, server_name)
          if lang_spec.lsp.config then
            M.lsp_configs[server_name] = lang_spec.lsp.config
          end
        end
        -- Multiple LSP servers format
        local servers = lang_spec.lsp.servers
        if servers then
          for _, srv in ipairs(servers) do
            table.insert(M.lsp_servers, srv)
            if lang_spec.lsp.configs and lang_spec.lsp.configs[srv] then
              M.lsp_configs[srv] = lang_spec.lsp.configs[srv]
            end
          end
        end
      end
      
      -- 2. Formatter configuration
      if lang_spec.formatters then
        for ft, fmts in pairs(lang_spec.formatters) do
          M.formatters_by_ft[ft] = fmts
        end
      end
      if lang_spec.formatter_configs then
        for name, config in pairs(lang_spec.formatter_configs) do
          M.formatters[name] = config
        end
      end
      
      -- 3. Linter configuration
      if lang_spec.linters then
        for ft, lnts in pairs(lang_spec.linters) do
          M.linters_by_ft[ft] = lnts
        end
      end
      if lang_spec.linter_configs then
        for name, config in pairs(lang_spec.linter_configs) do
          M.linters[name] = config
        end
      end
      
      -- 4. DAP Debugger configuration
      if lang_spec.dap then
        if lang_spec.dap.adapters then
          for name, adapter in pairs(lang_spec.dap.adapters) do
            M.dap_adapters[name] = adapter
          end
        end
        if lang_spec.dap.configurations then
          for ft, configs in pairs(lang_spec.dap.configurations) do
            M.dap_configurations[ft] = configs
          end
        end
      end
      
      -- 5. Test Adapter configuration
      if lang_spec.testing and lang_spec.testing.adapters then
        for name, adapter in pairs(lang_spec.testing.adapters) do
          M.test_adapters[name] = adapter
        end
      end
      
      -- 6. Tools installation list (LSPs, Formatters, Linters, Debuggers)
      if lang_spec.tools then
        for _, tool in ipairs(lang_spec.tools) do
          if not vim.tbl_contains(M.tools_to_install, tool) then
            table.insert(M.tools_to_install, tool)
          end
        end
      end
      
    else
      vim.notify("Failed to load language module: " .. lang_name, vim.log.levels.WARN)
    end
  end
end

return M
