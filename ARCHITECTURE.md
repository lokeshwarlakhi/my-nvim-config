# Neovim Configuration Architecture Guide

This document describes the architectural layout, startup sequence, performance design, and extension points of this premium Neovim IDE-grade configuration.

---

## 1. Directory Structure

The configuration is organized under `lua/` as a highly modular architecture where each subdirectory handles a single, well-defined concern:

```
~/.config/nvim/
├── init.lua                 # Main entry point; boots options, keymaps, lazy.nvim
├── lazy-lock.json           # Lockfile tracking exact plugin versions
│
├── lua/
│   ├── config/              # Central User Preferences
│   │   └── settings.lua     # Single source of truth for toggles and options
│   │
│   ├── core/                # Core Editor Settings
│   │   ├── options.lua      # Standard vim options (numbers, tabs, spacing)
│   │   ├── keymaps.lua      # Global keymaps (navigation, splits, tabs)
│   │   └── autocmds.lua     # Automatic hooks (yank highlight, terminal close)
│   │
│   ├── languages/           # Language Modules (LSP, Formatters, Linters, DAPs)
│   │   ├── init.lua         # Orchestrator: Dynamic compiler & loader
│   │   ├── python.lua       # Python spec (Ruff, Pyright, debugpy, pytest)
│   │   ├── go.lua           # Go spec (gopls, golangci-lint, dlv, neotest-go)
│   │   ├── rust.lua         # Rust spec (rust-analyzer, codelldb)
│   │   ├── typescript.lua   # TypeScript/JavaScript spec (ts_ls, prettier, eslint)
│   │   └── devops.lua       # SysOps bundle (Docker, YAML, Bash, Terraform, Bicep)
│   │
│   ├── lsp/                 # Shared LSP Utilities
│   │   └── keymaps.lua      # Buffer-local keymaps bound on LSP attach
│   │
│   ├── plugins/             # Lazy.nvim Specifications (categorized bundles)
│   │   ├── lsp.lua          # nvim-lspconfig + Mason auto-installer
│   │   ├── cmp.lua          # nvim-cmp completion + snippets + pictograms
│   │   ├── formatters.lua   # conform.nvim dynamic formatting
│   │   ├── linters.lua      # nvim-lint dynamic static analysis
│   │   ├── dap.lua          # nvim-dap debugger + DAP UI + virtual text
│   │   ├── testing.lua      # neotest + dynamic test runner adapters
│   │   ├── ui.lua           # Theme, statusline, bufferline, todo comments, aerial
│   │   ├── editor.lua       # comment, autopairs, surround, visual-multi
│   │   ├── git.lua          # gitsigns gutter blame, diffview panel
│   │   └── tools.lua        # toggleterm, docstring generator, markdown preview
│   │
│   └── utils/               # Shared Utilities
│       ├── helpers.lua      # Standard pcall wrapper, keymap generators
│       └── icons.lua        # Unified icon assets
```

---

## 2. Dynamic Language Orchestration

The core innovation of this architecture is the **Unified Language Registry** in `lua/languages/init.lua`. 

Instead of configuring LSP servers, Mason tools, Conform formatters, Nvim-lint linters, and DAP adapters in separate plugin files, they are defined in a single file per language (e.g. `lua/languages/python.lua`).

```
+-------------------------------------------------------------+
|                Language Spec (python.lua)                   |
| - LSP configuration settings (Pyright options)              |
| - Formatter specifications (ruff_format)                    |
| - Linter specifications (ruff, mypy)                        |
| - DAP adapter & run configurations (debugpy)                |
| - Neotest adapter & runner configurations (pytest)          |
| - Mason tools list to install                               |
+-------------------------------------------------------------+
                              │ (required by)
                              ▼
+-------------------------------------------------------------+
|             Central Orchestrator (init.lua)                 |
| Loops through enabled languages, aggregates configurations, |
| and builds global registries.                               |
+-------------------------------------------------------------+
         │                    │                     │
         ▼                    ▼                     ▼
+-----------------+  +-----------------+  +-----------------+
|   plugins/lsp   |  |   formatters    |  |     dap/tests   |
| Installs tools  |  | Feeds conform   |  | Sets up debugs  |
| via Mason &     |  | and nvim-lint   |  | & test runners  |
| registers LSPs  |  | configurations  |  | dynamically     |
+-----------------+  +-----------------+  +-----------------+
```

### Why this is superior:
1. **Maintainability**: Adding, modifying, or removing a programming language is isolated to **one file** under `lua/languages/`.
2. **Reproducibility**: When you enable a language module, `mason-tool-installer` reads its `tools` entry and automatically downloads all LSPs, formatters, and linters without requiring manual `:MasonInstall` commands.
3. **Consistency**: Keymaps and options remain identical across all filetypes.

---

## 3. Startup & Load Sequence

Neovim boots in a predictable sequence optimized for speed (targeting `<100ms` startup):

1. **`init.lua`** executes:
   - Sets leader key (`vim.g.mapleader = " "`).
   - Disables mouse support.
   - Loads `core.options` (Vim defaults).
   - Loads `core.keymaps` (Global keys).
   - Loads `core.autocmds` (Auto-commands).
2. **`languages` module** is required:
   - Evaluates `config/settings.lua` to see which languages are active.
   - Loads enabled languages from `lua/languages/` and compiles the unified registers.
3. **`lazy.nvim`** initializes:
   - Prepend `lazy.nvim` path to runtime path.
   - Loads all plugins under `lua/plugins/`.

---

## 4. Lazy Loading Strategy

To ensure high performance, plugins are only loaded when they are actually needed. This is controlled by Lazy.nvim events and commands:

| Plugin Category | Trigger | Rationale |
|---|---|---|
| **Theme (github-theme)** | `lazy = false` | Must load instantly to prevent screen flashing. |
| **LSP Infrastructure** | `BufReadPre`, `BufNewFile` | Loads as soon as you open a code file. |
| **Completion (cmp)** | `InsertEnter` | Loads when you switch to Insert mode to start typing. |
| **Formatting (conform)** | `BufWritePre` | Runs right before you save a buffer. |
| **Terminal (toggleterm)** | `cmd = "ToggleTerm"` | Loads when you press `<leader>t`. |
| **Debugger (dap)** | `keys` | Loaded on stepping or breakpoint key trigger. |
| **Outline (aerial)** | `keys` | Loaded when you press `<leader>o`. |
| **Git signs** | `BufReadPost` | Loaded on reading any file to scan git state. |

---

## 5. LSP & Autocomplete Mechanisms

### How LSP attaches to a buffer:
1. When a buffer is opened, `nvim-lspconfig` checks if the filetype matches a configured server (e.g. `pyright` for `.py` files).
2. If matched, it launches the server process in the background.
3. On connection, it triggers the `on_attach` handler defined in `lua/plugins/lsp.lua`.
4. `on_attach` executes:
   - Sets buffer-local keymaps from `lua/lsp/keymaps.lua` (e.g. `gd`, `K`, `<leader>rn`).
   - Starts document reference highlighting on cursor hold.
   - Activates inlay hints (like type signatures) inline if supported.

### How Autocomplete works:
1. The insertion cursor triggers `nvim-cmp`.
2. As you type, `cmp` queries its sources:
   - **`nvim_lsp`**: Obtains suggestions from active LSP server.
   - **`luasnip`**: Checks for matching snippets.
   - **`path`**: Provides filesystem folder autofill.
   - **`buffer`**: Offers text matching from the current file.
3. The matches are styled using `lspkind.nvim` to append clean icons and rounded borders to completion cards.
