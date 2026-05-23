-- ============================================================================
-- CENTRALIZED CONFIGURATION SETTINGS
-- ============================================================================
-- This module defines all global settings, paths, and configuration constants.
-- Purpose: Single source of truth for all configuration values
-- 
-- Usage:
--   local settings = require("config.settings")
--   print(settings.python_lsp)  -- Access any setting
-- 
-- ============================================================================

local M = {}

-- ============================================================================
-- PYTHON CONFIGURATION
-- ============================================================================
M.python = {
  -- Primary LSP: Choose between "pyright" (faster) or "basedpyright" (stricter)
  lsp = "pyright",
  
  -- Python venv detection: Automatically detects venv in common locations
  venv_detection = true,
  
  -- Type checking mode: "off" | "basic" | "standard" | "strict"
  type_checking = "basic",
  
  -- Auto import organization
  auto_imports = true,
}

-- ============================================================================
-- GO CONFIGURATION
-- ============================================================================
M.go = {
  lsp = "gopls",
  formatter = "gofmt",
  linter = "golangci-lint",
  debug_adapter = "dlv",
}

-- ============================================================================
-- RUST CONFIGURATION
-- ============================================================================
M.rust = {
  lsp = "rust_analyzer",
  formatter = "rustfmt",
  debug_adapter = "lldb",
  -- Enable inline hints
  inlay_hints = true,
}

-- ============================================================================
-- TYPESCRIPT / JAVASCRIPT CONFIGURATION
-- ============================================================================
M.typescript = {
  lsp = "tsserver",
  formatter = "prettier",
  linter = "eslint",
  debug_adapter = "node-debug2",
  -- Organize imports on save
  organize_imports = true,
}

-- ============================================================================
-- FORMATTING CONFIGURATION
-- ============================================================================
M.formatting = {
  -- Format on save (async)
  format_on_save = true,
  timeout_ms = 5000,
  
  -- Fallback to LSP if formatter unavailable
  lsp_fallback = true,
  
  -- Prettier path (can be overridden per-project)
  prettier_path = vim.fn.expand("~/.nvm/versions/node/v22.21.0/bin/prettier"),
}

-- ============================================================================
-- LINTING CONFIGURATION
-- ============================================================================
M.linting = {
  -- Lint on file save
  lint_on_save = true,
  
  -- Lint on buffer enter
  lint_on_enter = true,
  
  -- Disable specific linters per project if needed
  disabled_linters = {},
}

-- ============================================================================
-- LSP CONFIGURATION
-- ============================================================================
M.lsp = {
  -- Global LSP settings applied to all servers
  enable_hover_docs = true,
  enable_code_actions = true,
  enable_diagnostics = true,
  
  -- Diagnostic display settings
  diagnostics = {
    virtual_text = true,
    underline = false,
    signs = true,
    update_in_insert = false,
  },
  
  -- Hover documentation settings
  hover = {
    border = "rounded",
    focusable = true,
  },
}

-- ============================================================================
-- DEBUGGING CONFIGURATION (DAP)
-- ============================================================================
M.debugging = {
  -- Enable DAP for supported languages
  enabled = true,
  
  -- UI settings
  ui = {
    icons_enabled = true,
    controls_enabled = true,
    layouts_enabled = true,
  },
  
  -- Breakpoint settings
  breakpoints = {
    show_signs = true,
    logpoint_text = "●",
    breakpoint_text = "●",
  },
}

-- ============================================================================
-- TESTING CONFIGURATION
-- ============================================================================
M.testing = {
  -- Enable test runner (neotest)
  enabled = true,
  
  -- Auto-discover tests
  discovery_enabled = true,
}

-- ============================================================================
-- GIT CONFIGURATION
-- ============================================================================
M.git = {
  -- Enable gitsigns for git blame/changes
  enable_gitsigns = true,
  
  -- Enable neogit for git UI
  enable_neogit = false, -- Can be enabled later
}

-- ============================================================================
-- UI/UX CONFIGURATION
-- ============================================================================
M.ui = {
  -- Colorscheme: "github_dark_colorblind" | "github_light" | etc.
  colorscheme = "github_dark_colorblind",
  
  -- Terminal colors
  terminal_transparency = false,
  
  -- Border style: "rounded" | "single" | "double" | "solid"
  border = "rounded",
}

-- ============================================================================
-- PERFORMANCE CONFIGURATION
-- ============================================================================
M.performance = {
  -- Maximum startup time goal (in milliseconds)
  startup_target_ms = 100,
  
  -- Lazy load timeout
  lazy_load_timeout = 1000,
  
  -- Enable profiling on startup (run :StartupProfile)
  enable_startup_profiling = false,
}

-- ============================================================================
-- EDITOR DEFAULTS
-- ============================================================================
M.editor = {
  -- Line numbers: "absolute" | "relative" | "both"
  line_numbers = "both",
  
  -- Tab width in spaces
  tab_width = 2,
  
  -- Use spaces instead of tabs
  use_spaces = true,
  
  -- Cursor position: "block" | "line" | "underline"
  cursor_shape = "block",
  
  -- Mouse support
  mouse_enabled = false,
}

-- ============================================================================
-- PATHS AND DIRECTORIES
-- ============================================================================
M.paths = {
  -- Undo directory for persistent undo
  undo_dir = os.getenv("HOME") .. "/.vim/undodir",
  
  -- Mason tools directory
  mason_bin = vim.fn.expand("~/.local/share/nvim/mason/bin"),
}

-- ============================================================================
-- FUNCTION: Get setting with default fallback
-- ============================================================================
function M.get(key, default)
  local keys = vim.split(key, ".", { plain = true })
  local value = M
  for _, k in ipairs(keys) do
    if value[k] == nil then
      return default
    end
    value = value[k]
  end
  return value
end

return M
