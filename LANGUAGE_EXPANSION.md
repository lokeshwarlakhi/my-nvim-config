---
name: Language Expansion Guide
description: Step-by-step guide to add new language support
---

# 🌍 LANGUAGE EXPANSION GUIDE

This guide explains how to add support for a new programming language to your Neovim IDE.

---

## 🎯 Overview: What Gets Added

When you add a new language, you're typically setting up:

1. **LSP Server** - Language intelligence (definitions, completion, hover, etc.)
2. **Formatter** - Code formatting (optional but recommended)
3. **Linter** - Code analysis (optional but recommended)
4. **Debug Adapter** - Debugging support (optional)
5. **Test Runner** - Running tests (optional)
6. **Language Module** - Centralized configuration for the language

---

## 📋 Step-by-Step: Adding Language X

Let's use **Golang** as an example. Replace `go/golang/gopls` with your language.

### Step 1: Create Language Module

Create `lua/languages/go.lua`:

```lua
-- ============================================================================
-- GO LANGUAGE CONFIGURATION
-- ============================================================================
-- Purpose: Centralized Go language setup
-- Includes: LSP, formatter, linter, debugger
-- 
-- Usage:
--   This is automatically discovered and loaded by the main config
--
-- ============================================================================

return {
  -- ========================================================================
  -- LANGUAGE IDENTIFICATION
  -- ========================================================================
  name = "Go",
  filetype = "go",
  extensions = { ".go" },
  
  -- ========================================================================
  -- LSP SERVER CONFIGURATION
  -- ========================================================================
  lsp = {
    server = "gopls",              -- LSP server name
    
    -- Settings passed to LSP server
    settings = {
      gopls = {
        gofumpt = true,            -- Use gofumpt for formatting
        usePlaceholders = true,    -- Use parameter placeholders
        staticcheck = true,        -- Enable staticcheck analysis
        analyses = {
          unusedparams = true,
          unreachable = true,
        },
      },
    },
  },
  
  -- ========================================================================
  -- FORMATTER CONFIGURATION
  -- ========================================================================
  formatter = {
    command = "gofmt",             -- Formatter command
    args = {},                     -- No additional args needed
  },
  
  -- ========================================================================
  -- LINTER CONFIGURATION
  -- ========================================================================
  linter = {
    command = "golangci-lint",     -- Linter command
    args = { "run", "--out-format=json" },
  },
  
  -- ========================================================================
  -- DEBUG ADAPTER CONFIGURATION
  -- ========================================================================
  debugger = {
    adapter = "dlv",               -- Delve debugger for Go
    type = "go",
    
    -- Debug configurations (launch/attach)
    configurations = {
      {
        type = "go",
        name = "Launch",
        mode = "debug",
        program = "${fileDirname}",
      },
      {
        type = "go",
        name = "Attach",
        mode = "local",
        processId = function()
          return require("dap.utils").pick_process()
        end,
      },
    },
  },
  
  -- ========================================================================
  -- TEST RUNNER CONFIGURATION
  -- ========================================================================
  tests = {
    runner = "go",
    framework = "testing",  -- Standard Go testing package
    discover_command = "go test -list",
  },
  
  -- ========================================================================
  -- KEYMAPS
  -- ========================================================================
  -- Optional: Language-specific keymaps
  keymaps = {
    -- Example: <leader>gt for "Go test"
    -- { "n", "<leader>gt", ":GoTest<CR>", { desc = "Go test" } },
  },
}
```

### Step 2: Create LSP Server Configuration

Create `lua/lsp/servers/gopls.lua`:

```lua
-- ============================================================================
-- GOPLS LSP SERVER CONFIGURATION
-- ============================================================================
-- Purpose: Language-specific settings for Go's LSP server
-- Server Docs: https://github.com/golang/tools/wiki/gopls
--
-- ============================================================================

return {
  settings = {
    gopls = {
      -- Code formatting
      gofumpt = true,              -- Use gofumpt instead of gofmt
      
      -- Placeholders in completion
      usePlaceholders = true,      -- Fill in function parameters
      
      -- Analysis
      staticcheck = true,          -- Enable staticcheck linter
      analyses = {
        unusedparams = true,       -- Warn about unused parameters
        unreachable = true,        -- Warn about unreachable code
        nilness = true,            -- Check for nil dereferences
        shadow = false,            -- Don't warn about shadowed variables
      },
      
      -- Linting
      lint = "golangci-lint",      -- Use golangci-lint
      
      -- Diagnostics
      diagnosticsDelay = "500ms",
      
      -- Semantic tokens (for highlighting)
      semanticTokens = true,
      
      -- Memory limits
      memoryMode = "DegradeClosed",
    },
  },
}
```

### Step 3: Create Formatter Configuration

Create `lua/formatting/go.lua`:

```lua
-- ============================================================================
-- GO FORMATTER CONFIGURATION
-- ============================================================================
-- Purpose: Configure gofmt for Go code
--
-- ============================================================================

return {
  -- gofmt is usually called by gopls, but can be configured here
  formatters_by_ft = {
    go = { "gofmt" },
  },
  
  formatters = {
    gofmt = {
      command = "gofmt",
      args = {},
      stdin = true,
    },
  },
}
```

### Step 4: Create Linter Configuration

Create `lua/linting/go.lua`:

```lua
-- ============================================================================
-- GO LINTER CONFIGURATION
-- ============================================================================
-- Purpose: Configure linting for Go
--
-- ============================================================================

return {
  -- Configure linters for Go files
  linters_by_ft = {
    go = { "golangci-lint" },
  },
  
  -- golangci-lint configuration
  linters = {
    ["golangci-lint"] = {
      cmd = "golangci-lint",
      args = {
        "run",
        "--out-format=json",
        "--timeout=5m",
      },
      stdin = false,
      stream = "stdout",
      ignore_exitcode = true,
    },
  },
}
```

### Step 5: Optional - Create Debug Adapter Configuration

Create `lua/dap/adapters/go.lua`:

```lua
-- ============================================================================
-- GO DEBUG ADAPTER CONFIGURATION
-- ============================================================================
-- Purpose: Configure Delve debugger for Go
-- Requires: dlv (install via `go install github.com/go-delve/delve/cmd/dlv@latest`)
--
-- ============================================================================

return {
  -- Register dlv adapter
  adapters = {
    go = {
      type = "executable",
      command = "dlv",
      args = { "dap" },
    },
  },
  
  -- Debug configurations
  configurations = {
    {
      type = "go",
      name = "Launch",
      request = "launch",
      mode = "debug",
      program = "${fileDirname}",
      cwd = "${workspaceFolder}",
      trace = "verbose",
    },
    {
      type = "go",
      name = "Launch Package",
      request = "launch",
      mode = "debug",
      program = ".",
      cwd = "${workspaceFolder}",
    },
    {
      type = "go",
      name = "Attach",
      mode = "local",
      request = "attach",
      processId = function()
        return require("dap.utils").pick_process()
      end,
    },
  },
}
```

### Step 6: Optional - Create Test Runner Configuration

Create `lua/testing/go.lua`:

```lua
-- ============================================================================
-- GO TEST CONFIGURATION
-- ============================================================================
-- Purpose: Configure neotest for Go tests
--
-- ============================================================================

return {
  -- Neotest adapter configuration for Go
  adapters = {
    "neotest-go",  -- Requires: pip install neotest-go
  },
}
```

### Step 7: Update Central Settings

Edit `lua/config/settings.lua` and add Go settings:

```lua
-- ============================================================================
-- GO CONFIGURATION
-- ============================================================================
M.go = {
  lsp = "gopls",
  formatter = "gofmt",
  linter = "golangci-lint",
  debug_adapter = "dlv",
  -- ... other settings
}
```

### Step 8: Install Tools with Mason

In Neovim:
```vim
:Mason
" Then search and install:
" - gopls (LSP)
" - gofmt (formatter)
" - golangci-lint (linter)
" - dlv (debugger)
```

Or via command line:
```bash
mason install gopls gofmt golangci-lint delve
```

### Step 9: Test It Works

1. Create a test Go file:
```bash
cat > /tmp/test.go << 'EOF'
package main

import "fmt"

func main() {
    fmt.Println("Hello, Go!")
}
EOF
```

2. Open in Neovim:
```bash
nvim /tmp/test.go
```

3. Test LSP:
   - Move cursor: `gd` should show definition
   - Hover: `K` should show docs
   - Code action: `<leader>ca` should show options

4. Test formatting:
   - `:Format` should format the file

5. Test linting:
   - Linter should run automatically

---

## 🔄 Template: Minimal Language Setup

For a quick start, use this minimal template:

```lua
-- lua/languages/mylang.lua
return {
  name = "MyLanguage",
  filetype = "mylang",
  extensions = { ".mlang" },
  
  lsp = {
    server = "mylang_lsp",
    settings = {
      -- LSP server settings here
    },
  },
  
  formatter = {
    command = "mylang-fmt",
    args = {},
  },
  
  linter = {
    command = "mylang-lint",
    args = {},
  },
}
```

---

## ✅ Language Support Checklist

When adding a language, go through this checklist:

- [ ] LSP server installed via Mason
- [ ] LSP configuration created (`lua/lsp/servers/xxx.lua`)
- [ ] Language module created (`lua/languages/xxx.lua`)
- [ ] Formatter configured (if available)
- [ ] Linter configured (if available)
- [ ] Treesitter grammar added (in `lua/plugins/tree-sitter.lua`)
- [ ] Debug adapter configured (if available)
- [ ] Test runner configured (if available)
- [ ] Central settings updated (`lua/config/settings.lua`)
- [ ] Tools installed via Mason
- [ ] Tested in Neovim

---

## 📚 Example: Complete Language Addition (Rust)

Here's a complete example of adding Rust support:

### 1. Language module (`lua/languages/rust.lua`):
```lua
return {
  name = "Rust",
  filetype = "rust",
  extensions = { ".rs" },
  lsp = { server = "rust_analyzer" },
  formatter = { command = "rustfmt" },
  linter = { command = "clippy" },
  debugger = { adapter = "lldb" },
}
```

### 2. LSP config (`lua/lsp/servers/rust_analyzer.lua`):
```lua
return {
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = { command = "clippy" },
      inlayHints = { enable = true },
    },
  },
}
```

### 3. Formatter (`lua/formatting/rust.lua`):
```lua
return {
  formatters_by_ft = { rust = { "rustfmt" } },
  formatters = {
    rustfmt = { command = "rustfmt", args = { "--edition", "2021" } },
  },
}
```

### 4. Debugger (`lua/dap/adapters/rust.lua`):
```lua
return {
  adapters = {
    rust = {
      type = "executable",
      command = "lldb-vscode",
      name = "lldb",
    },
  },
  configurations = {
    {
      type = "rust",
      name = "Launch",
      request = "launch",
      program = "${cargo:program}",
      cwd = "${workspaceFolder}",
    },
  },
}
```

### 5. Install tools:
```vim
:Mason
" Install: rust-analyzer, rustfmt, clippy, lldb-vscode
```

---

## 🔗 Related Resources

- **ARCHITECTURE.md** - Overall config structure
- **MAINTENANCE_GUIDE.md** - Updating plugins and tools
- **PYTHON_WORKFLOW.md** - Python-specific detailed setup

---

## 🚀 Next Steps

Once you've added a language:

1. **Share configs** with team members
2. **Document project-specific setup** in `.nvim-project.lua`
3. **Create language-specific workflows** in comments
4. **Test in real projects** to catch issues

---
