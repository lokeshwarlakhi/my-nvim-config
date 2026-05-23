-- ============================================================================
-- RUST LANGUAGE MODULE
-- ============================================================================
-- Purpose: Specifications for Rust LSP (rust_analyzer), formatters, and debugging.
-- ============================================================================

local rust_spec = {
  -- LSP configuration
  lsp = {
    server = "rust_analyzer",
    config = {
      settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
          },
          procMacro = {
            enable = true,
          },
          checkOnSave = {
            command = "clippy",
          },
          diagnostics = {
            enable = true,
          },
          inlayHints = {
            enable = true,
            typeHints = { enable = true },
            parameterHints = { enable = true },
          }
        }
      }
    }
  },
  
  -- Formatter configuration
  formatters = {
    rust = { "rustfmt" },
  },
  formatter_configs = {
    rustfmt = {
      command = "rustfmt",
      args = { "--emit", "stdout", "--edition", "2021" },
      stdin = true,
    }
  },
  
  -- DAP configuration (Requires codelldb)
  dap = {
    adapters = {
      rt_lldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = "codelldb",
          args = { "--port", "${port}" },
        }
      }
    },
    configurations = {
      rust = {
        {
          type = "rt_lldb",
          request = "launch",
          name = "Cargo run",
          cargo = {
            args = { "run" }
          },
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
        {
          type = "rt_lldb",
          request = "launch",
          name = "Debug test",
          cargo = {
            args = { "test", "--no-run" }
          },
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        }
      }
    }
  },
  
  -- Mason tools list
  tools = {
    "rust-analyzer",
    "codelldb",
  }
}

return rust_spec
