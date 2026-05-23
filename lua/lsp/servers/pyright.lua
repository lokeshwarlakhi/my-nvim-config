-- ============================================================================
-- PYRIGHT LSP SERVER CONFIGURATION
-- ============================================================================
-- Purpose: Language-specific settings for Python's LSP
-- Server: Pyright (https://github.com/microsoft/pyright)
-- Alternative: basedpyright (stricter, slower)
--
-- Pyright is Microsoft's static type checker for Python. It's faster than
-- basedpyright and suitable for most Python projects.
--
-- ============================================================================

return {
  settings = {
    python = {
      -- Type checking mode: "off" | "basic" | "standard" | "strict"
      -- Choose based on project maturity and team skill
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
        
        -- Disable certain diagnostics if too noisy
        reportGeneralTypeIssues = true,
        reportOptionalMemberAccess = true,
        reportOptionalSubscript = true,
        reportPrivateImportUsage = false, -- Too strict for most projects
      },
      
      -- Virtual environment detection
      venv = "~/.venv",  -- Can be overridden per-project
      
      -- Python version (defaults to system Python)
      pythonVersion = "3.11",
      
      -- Path to Python executable (optional, auto-detected)
      pythonPath = "",
      
      -- Exclude patterns for analysis
      exclude = { "**/node_modules", "**/__pycache__", "**/.*" },
      
      -- Root path markers for monorepos
      root = ".",
    },
  },
}
