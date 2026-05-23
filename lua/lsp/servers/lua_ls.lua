-- ============================================================================
-- LUA_LS LSP SERVER CONFIGURATION
-- ============================================================================
-- Purpose: Language-specific settings for Lua
-- Server: lua-language-server (https://github.com/LuaLS/lua-language-server)
--
-- ============================================================================

return {
  settings = {
    Lua = {
      -- Runtime environment
      runtime = {
        version = "LuaJIT",          -- Neovim uses LuaJIT
        path = vim.split(package.path, ";"),
      },
      
      -- Diagnostics
      diagnostics = {
        globals = { "vim" },         -- Recognize vim global in Neovim configs
        disable = {},
      },
      
      -- Workspace
      workspace = {
        library = {
          vim.fn.expand("$VIMRUNTIME/lua"),
          "${3rd}/luv/library",
          "${3rd}/busted/library",
        },
        checkThirdParty = false,
      },
      
      -- Telemetry
      telemetry = {
        enable = false,
      },
    },
  },
}
