-- ============================================================================
-- LSP CONFIGURATION - BASE SETUP
-- ============================================================================
-- Purpose: Central LSP coordinator and base configuration
-- Responsibility: Load all LSP servers, setup capabilities, attach handlers
--
-- This module:
-- 1. Discovers all servers in lua/lsp/servers/*.lua
-- 2. Applies shared capabilities (completion, etc.)
-- 3. Sets up on_attach handler
-- 4. Registers keymaps
-- 5. Initializes handlers for LSP events
--
-- ============================================================================

local M = {}
local utils = require("utils.helpers")
local settings = require("config.settings")

-- ============================================================================
-- LSP DISCOVERY
-- ============================================================================

--- Discover all LSP servers from lua/lsp/servers/ directory
---@return table | {server_name: config, ...}
local function discover_servers()
  local servers = {}
  local config_dir = vim.fn.expand("~/.config/nvim/lua/lsp/servers")
  
  -- Scan directory for *.lua files
  local handle = vim.loop.fs_scandir(config_dir)
  if not handle then
    return servers
  end
  
  while true do
    local name, type = vim.loop.fs_scandir_next(handle)
    if not name then
      break
    end
    
    if type == "file" and name:match("%.lua$") then
      local server_name = name:gsub("%.lua$", "")
      local ok, config = pcall(require, "lsp.servers." .. server_name)
      
      if ok and config then
        servers[server_name] = config
        vim.notify("Discovered LSP: " .. server_name, vim.log.levels.DEBUG)
      else
        utils.warn("Failed to load LSP server: " .. server_name)
      end
    end
  end
  
  return servers
end

-- ============================================================================
-- CAPABILITIES SETUP
-- ============================================================================

--- Build LSP capabilities with completion and other features
---@return table | LSP capabilities
local function setup_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  
  -- Add nvim-cmp capabilities
  local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if ok then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  end
  
  -- Enable semantic tokens (syntax highlighting)
  capabilities.textDocument.semanticTokens = {
    dynamicRegistration = true,
    requests = {
      full = true,
      fullDelta = true,
      range = true,
    },
  }
  
  -- Enable inlay hints
  capabilities.textDocument.inlayHint = {
    dynamicRegistration = true,
  }
  
  return capabilities
end

-- ============================================================================
-- ON_ATTACH HANDLER
-- ============================================================================

--- LSP on_attach handler: called when LSP attaches to buffer
---@param client table | LSP client
---@param bufnr number | Buffer number
local function on_attach(client, bufnr)
  -- Load LSP keymaps
  require("lsp.keymaps")(client, bufnr)
  
  -- Highlight references on cursor hold
  if client.supports_method("textDocument/documentHighlight") then
    local augroup = vim.api.nvim_create_augroup("LSPReferences", { clear = false })
    vim.api.nvim_create_autocmd("CursorHold", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.clear_references()
      end,
    })
  end
  
  -- Format on save if enabled
  if settings.formatting.format_on_save and client.supports_method("textDocument/formatting") then
    local augroup = vim.api.nvim_create_augroup("LSPFormatting", { clear = false })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false, timeout_ms = settings.formatting.timeout_ms })
      end,
    })
  end
  
  -- Enable inlay hints if supported
  if client.supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(bufnr, true)
  end
end

-- ============================================================================
-- LSP SETUP
-- ============================================================================

--- Setup all discovered LSP servers
function M.setup()
  -- Setup Mason-lspconfig to manage installations
  local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
  if ok then
    mason_lspconfig.setup({
      -- Auto-install these servers
      ensure_installed = {
        "lua_ls",
        "pyright",
      },
    })
  end
  
  -- Get capabilities
  local capabilities = setup_capabilities()
  
  -- Discover and setup all LSP servers
  local servers = discover_servers()
  
  for server_name, server_config in pairs(servers) do
    local config = {
      capabilities = capabilities,
      on_attach = on_attach,
    }
    
    -- Merge server-specific settings
    if server_config.settings then
      config.settings = server_config.settings
    end
    
    -- Setup server
    vim.lsp.config(server_name, config)
    vim.lsp.enable(server_name)
    
    vim.notify("Configured LSP: " .. server_name, vim.log.levels.DEBUG)
  end
  
  -- Configure diagnostics
  setup_diagnostics()
end

-- ============================================================================
-- DIAGNOSTICS CONFIGURATION
-- ============================================================================

--- Configure diagnostic display (virtual text, signs, underline)
function setup_diagnostics()
  local opts = settings.lsp.diagnostics
  
  vim.diagnostic.config({
    virtual_text = opts.virtual_text and {
      prefix = "■",
      spacing = 2,
    } or false,
    underline = opts.underline,
    signs = opts.signs,
    update_in_insert = opts.update_in_insert,
    severity_sort = true,
  })
  
  -- Set diagnostic signs
  local sign = function(opts)
    vim.fn.sign_define(opts.name, {
      texthl = opts.name,
      text = opts.text,
      numhl = "",
    })
  end
  
  sign({ name = "DiagnosticSignError", text = "✗" })
  sign({ name = "DiagnosticSignWarn", text = "⚠" })
  sign({ name = "DiagnosticSignInfo", text = "ℹ" })
  sign({ name = "DiagnosticSignHint", text = "💡" })
end

-- ============================================================================
-- HANDLERS
-- ============================================================================

--- Setup LSP handlers (hover, signature help, etc.)
function M.setup_handlers()
  -- Hover documentation
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = settings.lsp.hover.border }
  )
  
  -- Signature help
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = settings.lsp.hover.border }
  )
end

-- ============================================================================
-- PUBLIC API
-- ============================================================================

--- Get all active LSP servers for current buffer
---@return table | Array of active server names
function M.get_active_servers()
  local clients = vim.lsp.get_active_clients()
  local servers = {}
  for _, client in ipairs(clients) do
    table.insert(servers, client.name)
  end
  return servers
end

--- Reload LSP configuration
function M.reload()
  vim.cmd("LspRestart")
  utils.info("LSP restarted")
end

return M
