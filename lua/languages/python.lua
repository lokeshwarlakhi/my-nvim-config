-- ============================================================================
-- PYTHON LANGUAGE MODULE
-- ============================================================================
-- Purpose: Specifications for Python LSPs, formatters, linters, debuggers, and tests.
-- ============================================================================

local settings = require("config.settings")

-- Helper to detect virtualenv python executable or fall back to pyenv envs with pytest
local function detect_python_path(root)
  local start_dir = root or vim.fn.getcwd()
  
  -- Helper to search upwards for venv
  local function find_venv(start_dir)
    local dir = start_dir
    while dir and dir ~= "" and dir ~= "/" do
      local venvs = {
        dir .. "/.venv/bin/python",
        dir .. "/venv/bin/python",
        dir .. "/env/bin/python",
        dir .. "/.env/bin/python",
      }
      for _, path in ipairs(venvs) do
        if vim.fn.executable(path) == 1 then
          return path
        end
      end
      local parent = vim.fn.fnamemodify(dir, ":h")
      if parent == dir then break end
      dir = parent
    end
    return nil
  end

  -- 1. Check current buffer directory upwards if no root is explicitly given
  if not root then
    local current_file = vim.api.nvim_buf_get_name(0)
    if current_file and current_file ~= "" then
      local file_dir = vim.fn.fnamemodify(current_file, ":p:h")
      local path = find_venv(file_dir)
      if path then return path end
    end
  end

  -- 2. Check the start_dir / root directory upwards
  local path = find_venv(start_dir)
  if path then return path end

  -- 3. Final fallback to system python
  return "python"
end

local lsp_server = settings.get("python.lsp", "pyright")
local type_checking = settings.get("python.type_checking", "basic")

local python_spec = {
  -- LSP configuration
  lsp = {
    server = lsp_server,
    config = {
      settings = {
        python = {
          analysis = {
            typeCheckingMode = type_checking,
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "workspace",
          }
        }
      }
    }
  },
  
  -- Formatter configuration (Conform)
  formatters = {
    python = { "ruff_format" },
  },
  formatter_configs = {
    ruff_format = {
      command = "ruff",
      args = { "format", "--stdin-filename", "$FILENAME", "-" },
      stdin = true,
    }
  },
  
  -- Linter configuration (Nvim-lint)
  linters = {
    python = { "ruff", "mypy" },
  },
  linter_configs = {},
  
  -- DAP configuration (Debugger)
  dap = {
    adapters = {
      python = {
        type = "executable",
        command = detect_python_path(),
        args = { "-m", "debugpy.adapter" },
      }
    },
    configurations = {
      python = {
        {
          type = "python",
          request = "launch",
          name = "Launch current file",
          program = "${file}",
          pythonPath = detect_python_path,
          console = "integratedTerminal",
        },
        {
          type = "python",
          request = "launch",
          name = "Launch with Arguments",
          program = "${file}",
          pythonPath = detect_python_path,
          args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " +")
          end,
          console = "integratedTerminal",
        },
        {
          type = "python",
          request = "launch",
          name = "Run tests (pytest)",
          module = "pytest",
          pythonPath = detect_python_path,
          console = "integratedTerminal",
        }
      }
    }
  },
  
  -- Neotest configuration
  testing = {
    adapters = {
      ["neotest-python"] = {
        runner = "pytest",
        python = detect_python_path,
      }
    }
  },
  
  -- Mason tools to ensure installed
  tools = {
    lsp_server,
    "ruff",
    "mypy",
    "debugpy",
  }
}

return python_spec
