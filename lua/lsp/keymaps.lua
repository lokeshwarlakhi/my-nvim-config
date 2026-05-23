-- ============================================================================
-- LSP KEYMAPS
-- ============================================================================
-- Purpose: Comprehensive LSP-related keybindings
-- Called: When LSP attaches to a buffer
--
-- Keymaps organized by category:
-- - Navigation (definitions, references, etc.)
-- - Refactoring (rename, code actions, imports)
-- - Information (hover, signature, symbols)
-- - Diagnostics (errors, warnings, fixes)
-- ============================================================================

return function(client, bufnr)
  -- Concise mapping helper
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = desc })
  end
  
  -- =========================================================================
  -- NAVIGATION
  -- =========================================================================
  
  map("n", "gd", vim.lsp.buf.definition, "Go to definition")
  map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
  map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
  map("n", "gt", vim.lsp.buf.type_definition, "Go to type definition")
  map("n", "gr", vim.lsp.buf.references, "Show references")
  
  -- Incoming calls (functions that call this function)
  if client:supports_method("textDocument/callHierarchy/incomingCalls") then
    map("n", "<leader>li", vim.lsp.buf.incoming_calls, "LSP incoming calls")
  end
  
  -- Outgoing calls (functions this calls)
  if client:supports_method("textDocument/callHierarchy/outgoingCalls") then
    map("n", "<leader>lo", vim.lsp.buf.outgoing_calls, "LSP outgoing calls")
  end
  
  -- =========================================================================
  -- INFORMATION / DOCUMENTATION
  -- =========================================================================
  
  map("n", "K", vim.lsp.buf.hover, "Hover documentation")
  map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
  map("n", "<leader>d", vim.diagnostic.open_float, "Show diagnostics")
  map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
  map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
  
  -- =========================================================================
  -- REFACTORING / CODE ACTIONS
  -- =========================================================================
  
  map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
  map("n", "<leader>ca", vim.lsp.buf.code_action, "Code actions")
  
  -- Organize imports (language-specific)
  if client:supports_method("textDocument/codeAction") then
    map("n", "<leader>co", function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = { "source.organizeImports" },
        },
      })
    end, "Organize imports")
  end
  
  -- Fix diagnostic at cursor (quick fix)
  if client:supports_method("textDocument/codeAction") then
    map("n", "<leader>cf", function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          diagnostics = { vim.diagnostic.get_cursor() },
        },
      })
    end, "Fix diagnostic")
  end
  
  -- Note: Formatting (<leader>lf) is handled by conform.nvim globally 
  -- to avoid overriding with fallback LSP formatting.
  
  -- =========================================================================
  -- SYMBOLS / OUTLINE
  -- =========================================================================
  
  -- Document symbols (show all symbols in current file)
  if client:supports_method("textDocument/documentSymbol") then
    map("n", "<leader>fs", vim.lsp.buf.document_symbol, "Document symbols")
  end
  
  -- Workspace symbols (search all symbols in project)
  if client:supports_method("workspace/symbol") then
    map("n", "<leader>fS", vim.lsp.buf.workspace_symbol, "Workspace symbols")
  end
  
  -- =========================================================================
  -- WORKSPACE MANAGEMENT
  -- =========================================================================
  
  -- Add folder to workspace
  if client:supports_method("workspace/didChangeWatchedFiles") then
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
  end
  
  -- Remove folder from workspace
  if client:supports_method("workspace/didChangeWatchedFiles") then
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
  end
  
  -- List workspace folders
  if client:supports_method("workspace/didChangeWatchedFiles") then
    map("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "List workspace folders")
  end
end