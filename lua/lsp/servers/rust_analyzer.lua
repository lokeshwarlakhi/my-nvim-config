-- ============================================================================
-- RUST_ANALYZER LSP SERVER CONFIGURATION
-- ============================================================================
-- Purpose: Language-specific settings for Rust
-- Server: rust-analyzer (https://rust-analyzer.github.io/)
--
-- rust-analyzer is the official Rust language server maintained by the Rust team.
--
-- ============================================================================

return {
  settings = {
    ["rust-analyzer"] = {
      -- Cargo integration
      cargo = {
        allFeatures = true,           -- Enable all cargo features
        loadOutDirsFromCheck = true,  -- Load build info from cargo check
        runBuildScripts = true,       -- Run build scripts
      },
      
      -- Type inference settings
      checkOnSave = {
        command = "clippy",           -- Use clippy for checking (stricter than check)
        allFeatures = true,
      },
      
      -- Inlay hints (inline type hints)
      inlayHints = {
        enable = true,
        chainingHints = true,         -- Show hints for chained method calls
        closingBraceHints = true,     -- Show hints for closing braces
        closureReturnTypeHints = true,
        lifetimeElisionHints = {
          enable = true,
          useParameterNames = true,
        },
        parameterHints = true,        -- Show parameter hints
        rangeHints = true,            -- Show range hints
        reborrowHints = true,         -- Show reborrow hints
        renderColons = true,          -- Show :: colons
        typeHints = true,             -- Show type hints
      },
      
      -- Completion settings
      completion = {
        autoimport = {
          enable = true,              -- Auto-import on completion
        },
        autoself = {
          enable = true,              -- Auto-self on completion
        },
      },
      
      -- Diagnostics
      diagnostics = {
        enable = true,
        disabled = {},                -- Disable specific diagnostics
        warningsAsHint = {},
        warningsAsInfo = {},
      },
      
      -- Semantic tokens for highlighting
      semanticHighlighting = {
        strings = {
          enable = true,
        },
      },
      
      -- Hover settings
      hover = {
        actions = {
          enable = true,
          implementations = true,
          references = true,
          run = true,
          debug = true,
        },
        documentation = {
          keywords = {
            enable = true,
          },
        },
      },
      
      -- Lens (code actions)
      lens = {
        enable = true,
        debug = true,
        implementations = true,
        references = true,
        run = true,
      },
    },
  },
}
