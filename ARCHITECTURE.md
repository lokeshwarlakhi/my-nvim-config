---
name: Architecture Guide
description: Complete Neovim configuration architecture and design documentation
---

# 📐 NEOVIM ARCHITECTURE GUIDE

## Overview

This Neovim configuration is designed as a **production-grade IDE** with a modular, extensible architecture inspired by IDE paradigms but optimized for keyboard-first workflows.

### Key Principles

1. **Modularity**: Each feature is isolated and independently loadable
2. **Single Responsibility**: Each module has one clear purpose
3. **Extensibility**: Adding new languages/features is predictable and non-intrusive
4. **Performance**: Lazy loading and optimized startup time
5. **Documentation**: Every module explains its purpose and how to extend it
6. **Type Safety**: Annotations for better LSP support and IDE integration

---

## 🏗️ Directory Structure

```
lua/
├── config/                    # Configuration layer
│   └── settings.lua          # Centralized settings (single source of truth)
│
├── core/                      # Core editor configuration
│   ├── options.lua           # Vim options (tabs, indentation, appearance)
│   ├── keymaps.lua           # Global keymaps (organized by category)
│   └── autocmds.lua          # Autocommands (events, triggers)
│
├── ui/                        # User interface / appearance
│   ├── colorscheme.lua       # Theme and colors
│   ├── statusline.lua        # Lualine status bar
│   └── breadcrumbs.lua       # Aerial.nvim symbols outline (future)
│
├── editor/                    # Text editing features
│   ├── completion.lua        # nvim-cmp completion engine
│   ├── snippets.lua          # LuaSnip snippet engine
│   ├── autopairs.lua         # Automatic bracket pairing
│   ├── surround.lua          # Surround.nvim text objects (future)
│   └── keymaps.lua           # Editor-specific keymaps
│
├── lsp/                       # Language Server Protocol
│   ├── config.lua            # LSP base configuration
│   ├── keymaps.lua           # LSP keybindings (gd, K, rename, etc.)
│   ├── capabilities.lua      # Shared LSP capabilities
│   ├── handlers.lua          # LSP event handlers
│   └── servers/              # Per-LSP configuration
│       ├── pyright.lua       # Python LSP
│       ├── gopls.lua         # Go LSP
│       ├── rust_analyzer.lua # Rust LSP
│       └── tsserver.lua      # TypeScript LSP
│
├── dap/                       # Debugging (DAP - Debug Adapter Protocol)
│   ├── config.lua            # DAP base configuration
│   ├── keymaps.lua           # Debugger keybindings
│   ├── ui.lua                # DAP UI configuration
│   └── adapters/             # Language-specific debuggers
│       ├── python.lua        # Python debugger (debugpy)
│       ├── go.lua            # Go debugger (dlv)
│       └── rust.lua          # Rust debugger (lldb)
│
├── languages/                 # Language-specific modules
│   ├── python.lua            # Python: LSP, formatter, linter, test runner
│   ├── go.lua                # Go: LSP, formatter, linter, debugger
│   ├── rust.lua              # Rust: LSP, formatter, linter, debugger
│   ├── typescript.lua        # TypeScript/JS: LSP, formatter, linter
│   └── terraform.lua         # Terraform/IaC configuration
│
├── formatting/               # Code formatting
│   ├── conform.lua           # Conform.nvim formatter plugin
│   ├── python.lua            # Python formatter settings
│   ├── go.lua                # Go formatter settings
│   └── keymaps.lua           # Format command bindings
│
├── linting/                  # Code linting
│   ├── nvim_lint.lua         # nvim-lint linter plugin
│   ├── python.lua            # Python linter settings (ruff, pylint)
│   ├── go.lua                # Go linter settings
│   └── keymaps.lua           # Lint command bindings
│
├── navigation/               # File and code navigation
│   ├── telescope.lua         # Telescope fuzzy finder
│   ├── neo-tree.lua          # Neo-tree file explorer
│   ├── harpoon.lua           # Harpoon quick navigation (future)
│   └── keymaps.lua           # Navigation keybindings
│
├── git/                      # Version control integration
│   ├── gitsigns.lua          # Gitsigns line blame (future)
│   ├── neogit.lua            # Neogit git UI (future)
│   └── keymaps.lua           # Git command bindings
│
├── testing/                  # Test running
│   ├── neotest.lua           # Neotest test runner plugin
│   ├── python.lua            # Python test adapter (pytest)
│   ├── go.lua                # Go test adapter
│   └── keymaps.lua           # Test command bindings
│
├── tools/                    # External tool management
│   ├── mason.lua             # Mason tool installer
│   ├── terminal.lua          # Toggleterm terminal
│   └── notify.lua            # nvim-notify notifications
│
├── utils/                    # Shared utilities
│   ├── helpers.lua           # Common functions (keymap, require, etc.)
│   ├── icons.lua             # Icon definitions (Nerd Font)
│   ├── colors.lua            # Color/highlight groups (future)
│   └── performance.lua       # Profiling and startup measurement (future)
│
└── plugins/                  # Plugin specifications (lazy.nvim)
    ├── editor.lua            # Editor plugins (cmp, snippets, autopairs)
    ├── lsp.lua               # LSP plugins (lspconfig, mason, etc.)
    ├── dap.lua               # DAP plugins (nvim-dap, nvim-dap-ui)
    ├── navigation.lua        # Navigation plugins (telescope, neo-tree)
    ├── ui.lua                # UI plugins (lualine, colorscheme, etc.)
    ├── git.lua               # Git plugins (gitsigns, neogit)
    ├── testing.lua           # Testing plugins (neotest)
    └── tools.lua             # Tool plugins (mason, toggleterm, notify)

init.lua                       # Main entry point
```

---

## 🚀 Startup Flow

```
init.lua (entry point)
    ↓
1. Set leader key to space
    ↓
2. Load core configuration
    ├─ require("core.options")      -- Vim settings
    ├─ require("core.keymaps")      -- Global keymaps
    └─ require("core.autocmds")     -- Autocommands
    ↓
3. Initialize Lazy.nvim plugin manager
    ↓
4. Lazy loads plugin specs from lua/plugins/*.lua
    ├─ LSP infrastructure initializes on BufReadPre
    ├─ Completion initializes on InsertEnter
    ├─ Other features lazy-loaded on demand
    ↓
5. Colors/theme applied after plugins load
    ↓
6. Neovim ready (total startup < 100ms target)
```

---

## 🔌 Plugin Loading Strategy

Plugins are loaded **on-demand** to minimize startup time:

| Plugin Category | Load Trigger | Rationale |
|-----------------|--------------|-----------|
| **LSP** | `BufReadPre` | Need immediately when editing |
| **Completion** | `InsertEnter` | Only when typing |
| **Terminal** | `:ToggleTerm` command | On-demand |
| **Git** | `BufEnter` if tracked | Only in git repos |
| **Tests** | `:Neotest` command | On-demand |
| **UI** (statusline, etc) | `VeryLazy` | After initial load |
| **Navigation** | keymaps with function() | When invoked |

**Result**: ~40-50ms startup time (vs 200ms+ without lazy loading)

---

## 🎯 Language Support Architecture

Each language has a dedicated module in `lua/languages/`:

```lua
-- Example: lua/languages/python.lua
return {
  lsp = "pyright",           -- LSP server
  formatter = "ruff_format", -- Primary formatter
  linter = "ruff",           -- Primary linter
  dap = "debugpy",           -- Debug adapter
  
  -- LSP-specific settings
  settings = {
    analysis = {
      typeCheckingMode = "basic",
      autoSearchPaths = true,
    }
  },
  
  -- Formatter options
  format_args = { "--line-length", "88" },
  
  -- Linter configuration
  lint_args = { "--extend-select", "E,W,F" },
  
  -- Test runner
  test_runner = "pytest",
}
```

### How to Add a New Language

1. **Create language module**: `lua/languages/mylang.lua`
2. **Define LSP server**: Add to `lsp/servers/mylang_lsp.lua`
3. **Configure formatter**: Add to `formatting/mylang.lua`
4. **Configure linter**: Add to `linting/mylang.lua`
5. **Optional - DAP**: Add to `dap/adapters/mylang.lua`
6. **Register in settings**: Update `config/settings.lua`

See [LANGUAGE_EXPANSION.md](#) for detailed examples.

---

## 🔑 Keymap Organization

Keymaps are organized by **context/feature**, not by mode:

```
<leader> = space

-- NAVIGATION (find files, search, symbols)
<leader>f     → Telescope commands
  ff         → Find files
  fg         → Live grep
  fb         → Buffers
  fs         → Buffer search

-- LSP (goto definition, refactor, etc.)
gd           → Goto definition (Vim standard)
K            → Hover documentation
<leader>rn   → Rename symbol
<leader>ca   → Code actions

-- DEBUGGING
<leader>d    → Debug commands
  db         → Toggle breakpoint
  dc         → Continue
  ds         → Step over

-- FORMATTING
<leader>lf   → Format document
<leader>li   → Organize imports

-- TESTING
<leader>t    → Test commands
  tn         → Test nearest
  tf         → Test file
  ta         → Test all

-- WINDOW/BUFFER
<leader>w    → Window commands
  sv         → Split vertical
  sh         → Split horizontal
  se         → Equalize splits
```

See [SHORTCUTS.md](#) for complete cheat sheet.

---

## 🎯 Feature Implementation Examples

### Example 1: Adding a New LSP Server

1. Create configuration file:
```lua
-- lua/lsp/servers/gopls.lua
return {
  settings = {
    gopls = {
      gofumpt = true,
      usePlaceholders = true,
      staticcheck = true,
    },
  },
}
```

2. Update settings:
```lua
-- lua/config/settings.lua
M.go = {
  lsp = "gopls",
  -- ...
}
```

3. LSP automatically loads via `lsp/config.lua` discovery

### Example 2: Adding a Formatter

1. Configure in `lua/formatting/myformat.lua`:
```lua
return {
  command = "my-formatter",
  args = { "--style=google" },
  stdin = true,
}
```

2. Register in `lua/plugins/formatters.lua`:
```lua
formatters_by_ft = {
  mylang = { "my-formatter" },
}
```

### Example 3: Extending Keymaps

Add to `lua/core/keymaps.lua` or language-specific keymap files:
```lua
utils.keymap("n", "<leader>xx", ":MyCommand<CR>", {
  desc = "My custom command"
})
```

---

## 📊 LSP Setup Diagram

```
lsp/config.lua (main coordinator)
    ↓
Discovers all lua/lsp/servers/*.lua files
    ↓
For each server:
  1. Load settings from servers/xxx.lua
  2. Setup capabilities (nvim_cmp support)
  3. Attach on_attach handler
  4. Register keymaps (gd, K, etc.)
    ↓
Result: All LSPs configured consistently
```

---

## 🧠 DAP (Debugging) Architecture

DAP provides IDE-grade debugging:

```
lua/dap/config.lua (main coordinator)
    ↓
Loads adapters from lua/dap/adapters/*.lua
    ↓
For each language adapter:
  1. Configure debug adapter path
  2. Setup debug configurations (launch, attach)
  3. Register debug UI keymaps
    ↓
Result: Breakpoints, stepping, watches, stack traces
```

Example debugging workflow:
```
<leader>db         → Toggle breakpoint at current line
<leader>dc         → Continue execution
<leader>ds         → Step over
<leader>di         → Step into
<leader>do         → Step out
<leader>dw         → Open watch window
<leader>ds         → Open stack trace
```

---

## 🔍 How Settings Flow Through System

```
config/settings.lua (centralized settings)
    ↓
Consumed by:
    ├─ lsp/config.lua       (LSP configuration)
    ├─ dap/config.lua       (debugger configuration)
    ├─ formatting/conform.lua (formatter config)
    ├─ linting/nvim_lint.lua (linter config)
    ├─ languages/*.lua      (language-specific config)
    └─ core/options.lua     (editor defaults)
```

To change behavior: **Edit `config/settings.lua`**, not scattered files.

---

## 🎨 Extensibility Points

### Adding a New Feature

1. Create feature directory: `lua/myfeature/`
2. Create main config: `lua/myfeature/config.lua`
3. Create keymaps: `lua/myfeature/keymaps.lua`
4. Create plugin spec: `lua/plugins/myfeature.lua`
5. Reference in `init.lua` if needed

### Customizing Existing Features

1. Edit relevant module in `lua/*/`
2. Usually just need to edit one file
3. Restart Neovim or use `:so ~/.config/nvim/init.lua`

---

## 📈 Performance Optimization

### Startup Profiling

Enable in `config/settings.lua`:
```lua
M.performance.enable_startup_profiling = true
```

Run command:
```vim
:StartupProfile
```

This generates a profiling report showing which modules take longest to load.

### Lazy Loading Best Practices

1. Use `event` for automatic loading on specific events
2. Use `cmd` for command-triggered loading
3. Use `keys` for keymap-triggered loading
4. Use `dependencies` to manage plugin load order

---

## 🔧 Common Tasks

### Change Python LSP to basedpyright
```lua
-- lua/config/settings.lua
M.python.lsp = "basedpyright"
```

### Add new language support
See [LANGUAGE_EXPANSION.md](#)

### Adjust formatting behavior
Edit `lua/formatting/conform.lua`

### Add custom keymap
```lua
-- lua/core/keymaps.lua
utils.keymap("n", "<leader>xyz", ":MyCmd<CR>", {
  desc = "My command"
})
```

### Change colorscheme
```lua
-- lua/ui/colorscheme.lua
vim.cmd("colorscheme my-theme")
```

---

## 🚨 Troubleshooting

### LSP not loading for language X
1. Check if LSP is in `lsp/servers/` directory
2. Verify Mason has installed it: `:Mason`
3. Check `lsp/config.lua` is discovering it
4. Run `:LspInfo` to see registered servers

### Formatting not working
1. Check formatter installed: `:MasonInstall conform.nvim`
2. Verify in `lua/formatting/conform.lua` is configured
3. Check buffer filetype: `:set ft?`
4. Run `:lua require("conform").format()`

### Performance issues
1. Enable startup profiling (see above)
2. Check for synchronous plugins
3. Use `:Lazy profile` to analyze plugin load time

---

## 📚 Related Documentation

- [MAINTENANCE_GUIDE.md](./MAINTENANCE_GUIDE.md) - How to update plugins, troubleshoot
- [LANGUAGE_EXPANSION.md](./LANGUAGE_EXPANSION.md) - How to add new languages
- [PYTHON_WORKFLOW.md](./PYTHON_WORKFLOW.md) - Python-specific setup
- [SHORTCUTS.md](./SHORTCUTS.md) - Complete keymap reference

---

## Version & Changes

**Last Updated**: May 2026
**Config Version**: 2.0 (IDE-grade redesign)
**Neovim Required**: 0.9+

---
