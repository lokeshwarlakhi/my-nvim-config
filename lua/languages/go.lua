-- ============================================================================
-- GO LANGUAGE MODULE
-- ============================================================================
-- Purpose: Specifications for Go LSP (gopls), formatters, linters, and debugging.
-- ============================================================================

local go_spec = {
  -- LSP configuration
  lsp = {
    server = "gopls",
    config = {
      settings = {
        gopls = {
          gofumpt = true,
          usePlaceholders = true,
          staticcheck = true,
          analyses = {
            unusedparams = true,
            shadow = true,
          },
          codelenses = {
            generate = true,
            gc_details = true,
            test = true,
            tidy = true,
          },
        }
      }
    }
  },
  
  -- Formatter configuration
  formatters = {
    go = { "gofumpt", "goimports" },
  },
  formatter_configs = {
    gofumpt = {
      command = "gofumpt",
      args = { "-" },
      stdin = true,
    },
    goimports = {
      command = "goimports",
      args = { "-srcdir", "$FILENAME", "-" },
      stdin = true,
    }
  },
  
  -- Linter configuration
  linters = {
    go = { "golangci-lint" },
  },
  linter_configs = {
    ["golangci-lint"] = {
      cmd = "golangci-lint",
      args = { "run", "--out-format", "json", "--issues-exit-code=0" },
      stdin = false,
      stream = "stdout",
      ignore_exitcode = true,
      parser = function(...)
        -- Uses default nvim-lint JSON parser for golangci-lint
        return require("lint.parser").from_json(...)
      end
    }
  },
  
  -- DAP configuration
  dap = {
    adapters = {
      go = {
        type = "server",
        port = "${port}",
        executable = {
          command = "dlv",
          args = { "dap", "-l", "127.0.0.1:${port}" },
        }
      }
    },
    configurations = {
      go = {
        {
          type = "go",
          name = "Debug file",
          request = "launch",
          program = "${file}",
        },
        {
          type = "go",
          name = "Debug test",
          request = "launch",
          mode = "test",
          program = "${file}",
        },
        {
          type = "go",
          name = "Debug package",
          request = "launch",
          program = "${fileDirname}",
        }
      }
    }
  },
  
  -- Test runner
  testing = {
    adapters = {
      ["neotest-go"] = {
        experimental = {
          test_table = true,
        },
        args = { "-v" }
      }
    }
  },
  
  -- Mason tools list
  tools = {
    "gopls",
    "gofumpt",
    "goimports",
    "golangci-lint",
    "delve",
  }
}

return go_spec
