-- ============================================================================
-- LSP CONFIGURATION & MASON INTEGRATION
-- ============================================================================
-- Purpose: Install and configure LSP servers, formatters, and linters.
--          Reads settings dynamically from central language orchestrator.
-- ============================================================================

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      local settings = require("config.settings")
      local lang_orchestrator = require("languages")
      
      -- Setup Mason
      require("mason").setup({
        ui = {
          border = settings.get("ui.border", "rounded"),
        }
      })
      
      -- Setup Mason Tool Installer (automatically installs all LSPs, linters, formatters, and debuggers)
      require("mason-tool-installer").setup({
        ensure_installed = lang_orchestrator.tools_to_install,
        auto_update = false,
        run_on_start = true,
      })
      
      -- Setup Mason LSP Config
      require("mason-lspconfig").setup()
      
      -- Define base capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      if cmp_ok then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end
      
      -- Enable semantic tokens and inlay hints
      capabilities.textDocument.semanticTokens = {
        dynamicRegistration = true,
        requests = {
          full = true,
          fullDelta = true,
          range = true,
        },
      }
      capabilities.textDocument.inlayHint = {
        dynamicRegistration = true,
      }
      
      -- Global on_attach
      local on_attach = function(client, bufnr)
        -- Attach LSP keymaps
        local keymaps_ok, keymaps = pcall(require, "lsp.keymaps")
        if keymaps_ok then
          keymaps(client, bufnr)
        end
        
        -- Highlight symbol references on hold
        if client:supports_method("textDocument/documentHighlight") then
          local group = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = group,
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            group = group,
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
          })
        end
        
        -- Show diagnostics tooltip on hover (VSCode style)
        local diag_group = vim.api.nvim_create_augroup("LspDiagnosticsHover", { clear = false })
        vim.api.nvim_create_autocmd({ "CursorHold" }, {
          group = diag_group,
          buffer = bufnr,
          callback = function()
            vim.diagnostic.open_float(nil, {
              focusable = false,
              close_events = { "CursorMoved", "CursorMovedI", "BufLeave", "InsertEnter" },
              border = "rounded",
              source = "always",
              prefix = " ",
              scope = "cursor",
            })
          end,
        })
        
        -- Enable inlay hints if supported by the server and enabled in settings
        if client:supports_method("textDocument/inlayHint") then
          local filetype = vim.bo[bufnr].filetype
          local hints_enabled = settings.get(filetype .. ".inlay_hints", false) or settings.get("lsp.inlay_hints", true)
          if hints_enabled then
            vim.lsp.inlay_hint.enable(bufnr, true)
          end
        end
      end
      
      -- Setup all LSP servers registered in our language registry
      require("lspconfig")
      for _, server in ipairs(lang_orchestrator.lsp_servers) do
        -- Skip manual configurations or custom setups if needed
        local server_opts = {
          capabilities = capabilities,
          on_attach = on_attach,
        }
        
        -- Merge language-specific configuration overrides
        local custom_opts = lang_orchestrator.lsp_configs[server] or {}
        server_opts = vim.tbl_deep_extend("force", server_opts, custom_opts)
        
        vim.lsp.config(server, server_opts)
        vim.lsp.enable(server)
      end
      
      -- Configure diagnostics styling (rounded borders, prefix indicators)
      local diag_opts = settings.get("lsp.diagnostics", {})
      vim.diagnostic.config({
        virtual_text = diag_opts.virtual_text and {
          prefix = "■",
          spacing = 4,
          format = function(diagnostic)
            local max_width = 45
            if string.len(diagnostic.message) > max_width then
              return string.sub(diagnostic.message, 1, max_width) .. "..."
            end
            return diagnostic.message
          end
        } or false,
        underline = diag_opts.underline,
        signs = diag_opts.signs,
        update_in_insert = diag_opts.update_in_insert,
        severity_sort = true,
        float = {
          border = "rounded",
          wrap = true,
        }
      })
      
      -- Rounded borders for float handlers
      local hover_border = settings.get("lsp.hover.border", "rounded")
      vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
        config = config or {}
        config.border = hover_border
        return vim.lsp.handlers.hover(err, result, ctx, config)
      end
      vim.lsp.handlers["textDocument/signatureHelp"] = function(err, result, ctx, config)
        config = config or {}
        config.border = hover_border
        return vim.lsp.handlers.signature_help(err, result, ctx, config)
      end
      
      -- Define standard diagnostic signs
      local signs = { Error = "✗", Warn = "⚠", Info = "ℹ", Hint = "💡" }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end
    end
  }
}