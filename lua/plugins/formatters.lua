-- ============================================================================
--  CONFORM.NVIM - FORMATTING CONFIGURATION
--  Better than null-ls for formatting with robust error handling
-- ============================================================================

return {
  "stevearc/conform.nvim",
  event = "BufWritePre",

  -- ==========================================================================
  --  MAIN CONFIGURATION OPTIONS
  -- ==========================================================================
  opts = {

    -- ##########################################################################
    --  FORMATTERS BY FILETYPE
    --  Define which formatter(s) to use for each file type
    -- ##########################################################################
    formatters_by_ft = {
      -- Python formatters
      python = { "ruff_format" }, -- Using black (alternative: ruff_format)

      -- Lua formatters
      lua = { "stylua" }, -- Lua formatter

      -- JavaScript/TypeScript ecosystem
      javascript = { "prettier" }, -- JavaScript
      typescript = { "prettier" }, -- TypeScript
      javascriptreact = { "prettier" }, -- React JS
      typescriptreact = { "prettier" }, -- React TS

      -- Web technologies
      html = { "prettier" }, -- HTML
      css = { "prettier" }, -- CSS
      scss = { "prettier" }, -- SCSS

      -- Data formats
      json = { "prettier" }, -- JSON
      yaml = { "prettier" }, -- YAML
      markdown = { "prettier" }, -- Markdown

      -- System languages (install via :MasonInstall)
      go = { "gofmt" }, -- Go (needs gofmt)
      rust = { "rustfmt" }, -- Rust (needs rustfmt)
      sh = { "shfmt" }, -- Shell (needs shfmt)

      -- ------------------------------------------------------------------------
      --  NOTE: Add more formatters below as needed
      --  Example: toml = { "taplo" }, sql = { "sqlfmt" }
      -- ------------------------------------------------------------------------
    },

    -- ##########################################################################
    --  ASYNC FORMATTING ON SAVE
    --  format_after_save allows async formatting without blocking
    -- ##########################################################################
    format_after_save = {
      timeout_ms = 5000, -- Increased timeout (5 seconds)
      lsp_fallback = true, -- Fallback to LSP if formatter fails
    },

    -- ##########################################################################
    --  FORMATTER-SPECIFIC CONFIGURATIONS
    --  Each formatter gets its own arguments and behavior
    -- ##########################################################################
    formatters = {

      -- ========================================================================
      --  PRETTIER - For JavaScript, TypeScript, JSON, CSS, HTML, etc.
      --  Path: ~/.nvm/versions/node/v22.21.0/bin/prettier
      -- ========================================================================
      prettier = {
        command = vim.fn.expand("~/.nvm/versions/node/v22.21.0/bin/prettier"),
        args = {
          "--stdin-filepath", -- Required for proper file context
          "$FILENAME", -- Pass the filename
          "--single-quote", -- Use single quotes
          "--trailing-comma", -- Add trailing commas
          "es5", -- ES5 style trailing commas
          "--tab-width", -- Set tab width
          "2", -- 2 spaces
          "--use-tabs", -- Use spaces, not tabs
          "false", -- Don't use tabs
        },
        stdin = true, -- Read from stdin (CRITICAL)
        timeout_ms = 5000, -- Timeout for large files
      },

      -- ========================================================================
      --  BLACK - Python formatter
      --  Path: ~/.local/share/nvim/mason/bin/black
      --  Alternative: Use ruff_format (faster) if black continues to timeout
      -- ========================================================================
      ruff_format = {
        command = vim.fn.expand("~/.local/share/nvim/mason/bin/ruff"),
        args = {
          "format",
          "--stdin-filename", -- Set line length
          "$FILENAME",
          "-",
        },
        stdin = true, -- Pipe buffer content to formatter
        timeout_ms = 5000, -- Allow 5 seconds for black
        -- env = { -- Environment variables
        --   PYTHONIOENCODING = "utf-8", -- Ensure UTF-8 encoding
        -- },
      },

      -- ========================================================================
      --  STYLUA - Lua formatter
      --  Path: ~/.local/share/nvim/mason/bin/stylua
      --  If still failing, try lua-format as alternative
      -- ========================================================================
      stylua = {
        command = vim.fn.expand("~/.local/share/nvim/mason/bin/stylua"),
        args = {
          "--indent-type", -- Type of indentation
          "Spaces", -- Use spaces (not tabs)
          "--indent-width", -- Indent width
          "2", -- 2 spaces
          "--column-width", -- Max line length
          "120", -- 120 columns
          "--search-parent-directories", -- Look for .stylua.toml config
          "-", -- Read from stdin (CRITICAL)
        },
        stdin = true, -- Pipe buffer content
        timeout_ms = 3000, -- 3 second timeout
      },

      -- ========================================================================
      --  SHFMT - Shell script formatter
      --  Path: ~/.local/share/nvim/mason/bin/shfmt (install via Mason)
      -- ========================================================================
      shfmt = {
        command = vim.fn.expand("~/.local/share/nvim/mason/bin/shfmt"),
        args = {
          "-i", -- Indent size
          "2", -- 2 spaces
          "-ci", -- Indent switch cases
          "-bn", -- Binary ops start new line
          "-sr", -- Redirect operators
          "-", -- Read from stdin (CRITICAL)
        },
        stdin = true,
      },

      -- ========================================================================
      --  GOFMT - Go formatter (requires Go installed)
      --  Install via: :MasonInstall gofmt
      -- ========================================================================
      gofmt = {
        command = vim.fn.expand("~/.local/share/nvim/mason/bin/gofmt"),
        args = {
          "-", -- Read from stdin
        },
        stdin = true,
      },

      -- ========================================================================
      --  RUSTFMT - Rust formatter (requires Rust installed)
      --  Install via: rustup component add rustfmt
      -- ========================================================================
      rustfmt = {
        command = vim.fn.expand("~/.cargo/bin/rustfmt"),
        args = {
          "--emit",
          "stdout", -- Output to stdout
          "--edition",
          "2021", -- Rust edition
        },
        stdin = true,
      },
    }, -- End formatters table
  }, -- End opts table

  -- ==========================================================================
  --  CONFIGURATION FUNCTION
  --  Setup conform with custom debugging and keymaps
  -- ==========================================================================
  config = function(_, opts)
    require("conform").setup(opts)

    -- --------------------------------------------------------------------------
    --  HELPER: Check if formatters are working
    --  Run :CheckFormatters to see which formatters are available
    -- --------------------------------------------------------------------------
    local function check_formatters()
      print("\n=== Checking Formatters ===\n")
      local formatters = { "black", "stylua", "prettier", "shfmt", "gofmt", "rustfmt" }
      for _, fmt in ipairs(formatters) do
        local executable = vim.fn.executable(fmt)
        local path = vim.fn.exepath(fmt)
        if executable == 1 then
          print("✓ " .. fmt .. ": " .. path)
        else
          print("✗ " .. fmt .. ": NOT FOUND")
        end
      end
      print("\n=== Available from Conform ===\n")
      local available = require("conform").list_formatters()
      print(table.concat(available, "\n"))
    end

    vim.api.nvim_create_user_command("CheckFormatters", check_formatters, {})

    -- --------------------------------------------------------------------------
    --  DEBUG COMMAND: Manual format with verbose output
    --  Run :FormatVerbose to format current buffer with detailed logging
    -- --------------------------------------------------------------------------
    vim.api.nvim_create_user_command("FormatVerbose", function()
      local success, err = pcall(function()
        require("conform").format({
          timeout_ms = 10000, -- Longer timeout for debugging
          lsp_fallback = true,
          quiet = false, -- Show all output
          verbose = true, -- Verbose logging
        })
      end)

      if not success then
        vim.notify("Format error: " .. tostring(err), vim.log.levels.ERROR)
      else
        vim.notify("Format completed successfully!", vim.log.levels.INFO)
      end
    end, {})

    -- --------------------------------------------------------------------------
    --  KEYMAPS: Manual formatting commands
    --  <leader>fm - Format current buffer manually
    --  <leader>fc - Format with custom timeout (10 seconds)
    -- --------------------------------------------------------------------------
    vim.keymap.set("n", "<leader>fm", function()
      require("conform").format({
        timeout_ms = 5000,
        lsp_fallback = true,
      })
    end, { desc = "Format current buffer" })

    vim.keymap.set("n", "<leader>fc", function()
      require("conform").format({
        timeout_ms = 10000,
        lsp_fallback = true,
      })
    end, { desc = "Format with custom timeout" })

    -- --------------------------------------------------------------------------
    --  AUTOCMD: Skip formatting for files with syntax errors (Python only)
    --  This prevents black from failing on invalid Python code
    -- --------------------------------------------------------------------------
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.py",
      callback = function()
        -- Check for obvious syntax errors using :make
        local has_errors = vim.fn.search("error") ~= 0
        if has_errors then
          vim.notify("Skipping format due to syntax errors", vim.log.levels.WARN)
          -- You can optionally stop the format here
        end
      end,
    })

    -- --------------------------------------------------------------------------
    --  DEBUG: Log when formatting starts and ends
    --  Uncomment to see when formatters are triggered
    -- --------------------------------------------------------------------------
    -- vim.api.nvim_create_autocmd("User", {
    --   pattern = "ConformPreFormat",
    --   callback = function()
    --     print("[Conform] Starting format: " .. vim.fn.expand("%:t"))
    --   end,
    -- })
    --
    -- vim.api.nvim_create_autocmd("User", {
    --   pattern = "ConformPostFormat",
    --   callback = function()
    --     print("[Conform] Format completed: " .. vim.fn.expand("%:t"))
    --   end,
    -- })
  end, -- End config function
} -- End return
