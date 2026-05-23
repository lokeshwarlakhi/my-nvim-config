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
--
-- Standard conventions:
-- - gd      = Go to Definition (Vim standard)
-- - gr      = Go to References
-- - gi      = Go to Implementation
-- - K       = Hover documentation
-- - <leader>rn = Rename symbol
-- - <leader>ca = Code actions
--
-- ============================================================================

return function(client, bufnr)
  local utils = require("utils.helpers")
  
  -- =========================================================================
  -- NAVIGATION
  -- =========================================================================
  
  -- Go to definition
  utils.keymap("n", "gd", vim.lsp.buf.definition, {
    desc = "Go to definition",
    buffer = bufnr,
  })
  
  -- Go to declaration
  utils.keymap("n", "gD", vim.lsp.buf.declaration, {
    desc = "Go to declaration",
    buffer = bufnr,
  })
  
  -- Go to implementation
  utils.keymap("n", "gi", vim.lsp.buf.implementation, {
    desc = "Go to implementation",
    buffer = bufnr,
  })
  
  -- Go to type definition
  utils.keymap("n", "gt", vim.lsp.buf.type_definition, {
    desc = "Go to type definition",
    buffer = bufnr,
  })
  
  -- Go to references
  utils.keymap("n", "gr", vim.lsp.buf.references, {
    desc = "Show references",
    buffer = bufnr,
  })
  
  -- Incoming calls (functions that call this function)
  if client.supports_method("textDocument/callHierarchy/incomingCalls") then
    utils.keymap("n", "<leader>li", vim.lsp.buf.incoming_calls, {
      desc = "LSP incoming calls",
      buffer = bufnr,
    })
  end
  
  -- Outgoing calls (functions this calls)
  if client.supports_method("textDocument/callHierarchy/outgoingCalls") then
    utils.keymap("n", "<leader>lo", vim.lsp.buf.outgoing_calls, {
      desc = "LSP outgoing calls",
      buffer = bufnr,
    })
  end
  
  -- =========================================================================
  -- INFORMATION / DOCUMENTATION
  -- =========================================================================
  
  -- Hover documentation
  utils.keymap("n", "K", vim.lsp.buf.hover, {
    desc = "Hover documentation",
    buffer = bufnr,
  })
  
  -- Signature help
  utils.keymap("i", "<C-k>", vim.lsp.buf.signature_help, {
    desc = "Signature help",
    buffer = bufnr,
  })
  
  -- Show line diagnostics
  utils.keymap("n", "<leader>d", vim.diagnostic.open_float, {
    desc = "Show diagnostics",
    buffer = bufnr,
  })
  
  -- Previous diagnostic
  utils.keymap("n", "[d", vim.diagnostic.goto_prev, {
    desc = "Previous diagnostic",
    buffer = bufnr,
  })
  
  -- Next diagnostic
  utils.keymap("n", "]d", vim.diagnostic.goto_next, {
    desc = "Next diagnostic",
    buffer = bufnr,
  })
  
  -- =========================================================================
  -- REFACTORING / CODE ACTIONS
  -- =========================================================================
  
  -- Rename symbol
  utils.keymap("n", "<leader>rn", vim.lsp.buf.rename, {
    desc = "Rename symbol",
    buffer = bufnr,
  })
  
  -- Code actions
  utils.keymap("n", "<leader>ca", vim.lsp.buf.code_action, {
    desc = "Code actions",
    buffer = bufnr,
  })
  
  -- Organize imports (language-specific)
  if client.supports_method("textDocument/codeAction") then
    utils.keymap("n", "<leader>co", function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = { "source.organizeImports" },
        },
      })
    end, {
      desc = "Organize imports",
      buffer = bufnr,
    })
  end
  
  -- Fix diagnostic at cursor (quick fix)
  if client.supports_method("textDocument/codeAction") then
    utils.keymap("n", "<leader>cf", function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          diagnostics = { vim.diagnostic.get_cursor() },
        },
      })
    end, {
      desc = "Fix diagnostic",
      buffer = bufnr,
    })
  end
  
  -- =========================================================================
  -- FORMATTING
  -- =========================================================================
  
  -- Format buffer
  if client.supports_method("textDocument/formatting") then
    utils.keymap("n", "<leader>lf", function()
      vim.lsp.buf.format({ async = true })
    end, {
      desc = "Format buffer",
      buffer = bufnr,
    })
  end
  
  -- Format selection (visual mode)
  if client.supports_method("textDocument/rangeFormatting") then
    utils.keymap("v", "<leader>lf", function()
      vim.lsp.buf.format({ async = true })
    end, {
      desc = "Format selection",
      buffer = bufnr,
    })
  end
  
  -- =========================================================================
  -- SYMBOLS / OUTLINE
  -- =========================================================================
  
  -- Document symbols (show all symbols in current file)
  if client.supports_method("textDocument/documentSymbol") then
    utils.keymap("n", "<leader>fs", vim.lsp.buf.document_symbol, {
      desc = "Document symbols",
      buffer = bufnr,
    })
  end
  
  -- Workspace symbols (search all symbols in project)
  if client.supports_method("workspace/symbol") then
    utils.keymap("n", "<leader>fS", vim.lsp.buf.workspace_symbol, {
      desc = "Workspace symbols",
      buffer = bufnr,
    })
  end
  
  -- =========================================================================
  -- WORKSPACE MANAGEMENT
  -- =========================================================================
  
  -- Add folder to workspace
  if client.supports_method("workspace/didChangeWatchedFiles") then
    utils.keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, {
      desc = "Add workspace folder",
      buffer = bufnr,
    })
  end
  
  -- Remove folder from workspace
  if client.supports_method("workspace/didChangeWatchedFiles") then
    utils.keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, {
      desc = "Remove workspace folder",
      buffer = bufnr,
    })
  end
  
  -- List workspace folders
  if client.supports_method("workspace/didChangeWatchedFiles") then
    utils.keymap("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, {
      desc = "List workspace folders",
      buffer = bufnr,
    })
  end
  
  -- =========================================================================
  -- HIGHLIGHTS & REFERENCES
  -- =========================================================================
  
  -- Clear highlight on CursorMoved (handled in lsp/config.lua)
  -- Document highlight is also handled automatically in config.lua
end