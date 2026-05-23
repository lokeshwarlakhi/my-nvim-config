-- ============================================================================
-- GOPLS LSP SERVER CONFIGURATION
-- ============================================================================
-- Purpose: Language-specific settings for Go
-- Server: gopls (https://github.com/golang/tools/wiki/gopls)
--
-- Gopls is the official language server for Go, maintained by the Go team.
--
-- ============================================================================

return {
  settings = {
    gopls = {
      -- Code formatting & style
      gofumpt = true,                 -- Use gofumpt instead of gofmt
      
      -- Completion settings
      usePlaceholders = true,         -- Fill in function parameters
      completeUnimported = true,      -- Auto-import missing packages
      
      -- Analysis
      staticcheck = true,             -- Enable staticcheck linter
      analyses = {
        unusedparams = true,          -- Warn about unused parameters
        unreachable = true,           -- Warn about unreachable code
        nilness = true,               -- Check for nil dereferences
        shadow = false,               -- Don't warn about shadowed variables
        deepequalerrors = true,       -- Warn about reflect.DeepEqual usage
        composites = true,            -- Check unkeyed composite literals
      },
      
      -- Diagnostics
      diagnosticsDelay = "500ms",
      
      -- Semantic tokens for syntax highlighting
      semanticTokens = true,
      
      -- Memory
      memoryMode = "DegradeClosed",
      
      -- Experimental features
      hints = {
        assignVariableTypes = true,   -- Inlay hints for variable types
        compositeLiteralFields = true, -- Hints for struct fields
        compositeLiteralTypes = true,  -- Hints for composite types
        constantValues = true,        -- Hints for constant values
        functionTypeParameters = true, -- Hints for function type params
        parameterNames = true,        -- Hints for parameter names
        rangeVariableTypes = true,    -- Hints for range variable types
      },
    },
  },
}
