-- ============================================================================
-- LSP INITIALIZATION
-- ============================================================================
-- Purpose: Orchestrate LSP setup
-- This module delegates to lua/lsp/config.lua for the main setup
-- ============================================================================

-- Load and run LSP configuration
require("lsp.config").setup()

-- Setup handlers (hover, signature help, etc.)
require("lsp.config").setup_handlers()

