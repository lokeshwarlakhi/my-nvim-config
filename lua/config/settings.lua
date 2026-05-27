-- ============================================================================
-- CENTRALIZED CONFIGURATION SETTINGS
-- ============================================================================
-- Purpose: Single source of truth for features, servers, and visual settings.
-- ============================================================================

local M = {}

-- ============================================================================
-- LANGUAGE MODULE STATUS (Toggle languages on/off)
-- ============================================================================
M.languages = {
  python = true,
  go = false,
  rust = false,
  typescript = true,
  devops = true, -- Docker, YAML, Bash, Terraform, Bicep, Kubernetes
}

-- ============================================================================
-- PYTHON CONFIGURATION
-- ============================================================================
M.python = {
  -- LSP choice: "pyright" (faster, standard) or "basedpyright" (stricter type checking)
  lsp = "pyright",
  
  -- Auto-detection of virtual environments (.venv, venv, env)
  venv_detection = true,
  
  -- Python analysis options
  type_checking = "basic", -- "off" | "basic" | "standard" | "strict"
  auto_imports = true,
}

-- ============================================================================
-- GO CONFIGURATION
-- ============================================================================
M.go = {
  lsp = "gopls",
  formatter = "gofumpt", -- "gofmt" | "gofumpt"
  linter = "golangci-lint",
}

-- ============================================================================
-- RUST CONFIGURATION
-- ============================================================================
M.rust = {
  lsp = "rust_analyzer",
  formatter = "rustfmt",
  inlay_hints = true,
}

-- ============================================================================
-- TYPESCRIPT & JAVASCRIPT CONFIGURATION
-- ============================================================================
M.typescript = {
  lsp = "ts_ls", -- updated from tsserver
  formatter = "prettier",
  linter = "eslint",
  organize_imports = true,
}

-- ============================================================================
-- FORMATTING & LINTING SETTINGS
-- ============================================================================
M.formatting = {
  format_on_save = true,
  timeout_ms = 5000,
  lsp_fallback = true,
}

M.linting = {
  lint_on_save = true,
  lint_on_enter = true,
  disabled_linters = {},
}

-- ============================================================================
-- LSP INFRASTRUCTURE
-- ============================================================================
M.lsp = {
  enable_hover_docs = true,
  enable_code_actions = true,
  enable_diagnostics = true,
  
  diagnostics = {
    virtual_text = true,
    underline = true,
    signs = true,
    update_in_insert = false,
  },
  
  hover = {
    border = "rounded",
    focusable = true,
  },
}

-- ============================================================================
-- DEBUGGING (DAP)
-- ============================================================================
M.debugging = {
  enabled = true,
  ui = {
    icons_enabled = true,
    controls_enabled = true,
  },
}

-- ============================================================================
-- TESTING (Neotest)
-- ============================================================================
M.testing = {
  enabled = true,
  discovery_enabled = true,
}

-- ============================================================================
-- GIT SETTINGS
-- ============================================================================
M.git = {
  enable_gitsigns = true,
  enable_diffview = true,
}

-- ============================================================================
-- UI & VISUAL APPEARANCE
-- ============================================================================
M.ui = {
  -- Colorscheme options: github_light_default, catppuccin, gruvbox, etc.
  colorscheme = "github_light_default",
  border = "rounded",
}

-- ============================================================================
-- EDITOR PREFERENCES
-- ============================================================================
M.editor = {
  line_numbers = "both", -- "absolute" | "relative" | "both" | "none"
  tab_width = 2,
  use_spaces = true,
  cursor_shape = "block",
  mouse_enabled = false,
  sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions",
}

-- ============================================================================
-- PATHS & BINARIES
-- ============================================================================
M.paths = {
  undo_dir = os.getenv("HOME") .. "/.vim/undodir",
  mason_bin = vim.fn.expand("~/.local/share/nvim/mason/bin"),
}

-- ============================================================================
-- FUNCTION: Get setting with fallback
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
