-- ============================================================================
-- TYPESCRIPT & JAVASCRIPT LANGUAGE MODULE
-- ============================================================================
-- Purpose: Specifications for TS/JS LSP (ts_ls), formatting, and linting.
-- ============================================================================

local ts_spec = {
  -- LSP configuration
  lsp = {
    server = "ts_ls",
    config = {
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          }
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          }
        }
      }
    }
  },
  
  -- Formatter configuration (using Prettier)
  formatters = {
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
  },
  formatter_configs = {
    prettier = {
      command = "prettier",
      args = { "--stdin-filepath", "$FILENAME", "--single-quote", "--trailing-comma", "es5", "--tab-width", "2" },
      stdin = true,
    }
  },
  
  -- Linter configuration (using ESLint)
  linters = {
    javascript = { "eslint" },
    typescript = { "eslint" },
    javascriptreact = { "eslint" },
    typescriptreact = { "eslint" },
  },
  linter_configs = {},
  
  -- DAP Configuration (JavaScript Debug Adapter)
  dap = {
    adapters = {
      node_debug = {
        type = "executable",
        command = "node",
        args = { vim.fn.stdpath("data") .. "/lazy/vscode-js-debug/out/src/vsDebugServer.js", "${port}" },
      }
    },
    configurations = {
      javascript = {
        {
          type = "node_debug",
          request = "launch",
          name = "Launch File",
          program = "${file}",
          cwd = "${workspaceFolder}",
        }
      },
      typescript = {
        {
          type = "node_debug",
          request = "launch",
          name = "Launch File",
          program = "${file}",
          cwd = "${workspaceFolder}",
          runtimeArgs = { "-r", "ts-node/register" },
        }
      }
    }
  },
  
  -- Mason tools list
  tools = {
    "typescript-language-server", -- mapped to ts_ls
    "prettier",
    "eslint-lsp", -- eslint LSP or linter wrapper
    "js-debug-adapter",
  }
}

return ts_spec
