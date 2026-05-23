# Configuration Structure Explanation

The Neovim codebase has been refactored into a lean, highly organized modular structure. There are no unused files, duplicate plugin definitions, or empty folders.

Here is the final structure:

```
~/.config/nvim/
├── init.lua                   # Entry point (sets up lazy.nvim and loads core modules)
├── ARCHITECTURE.md            # Overall code design manual
├── GETTING_STARTED.md         # Onboarding & test suite verify playbook
├── LANGUAGE_EXPANSION.md      # How to add support for a new language
├── MAINTENANCE_GUIDE.md       # Upgrades, debugging, and backup procedures
├── PYTHON_WORKFLOW.md         # Advanced debugging, linting, and testing workflows
├── SHORTCUTS.md               # Keymaps reference list
├── CLEANUP_REPORT.md          # Log of deleted and refactored components
├── MIGRATION_NOTES.md         # Editing changes to be aware of
│
├── lua/
│   ├── config/
│   │   └── settings.lua       # Central settings toggles (languages, theme, etc.)
│   │
│   ├── core/
│   │   ├── options.lua        # Basic vim options (line wrap, clipboard, etc.)
│   │   ├── keymaps.lua        # Global editor keymaps (splits, navigation, window)
│   │   └── autocmds.lua       # System-level event triggers (yank flash, exit cleanup)
│   │
│   ├── lsp/
│   │   └── keymaps.lua        # Keymaps attached to buffers only when LSP is active
│   │
│   ├── languages/
│   │   ├── init.lua           # Orchestrator (loads specifications dynamically)
│   │   ├── python.lua         # Python LSP, Ruff formatting, linters, tests, and DAP
│   │   ├── go.lua             # Go LSP, formatters, and testing
│   │   ├── rust.lua           # Rust spec details
│   │   ├── typescript.lua     # JS/TS Prettier formatter, linters, and LSP
│   │   └── devops.lua         # Docker, YAML, Bash, Terraform, Bicep configs
│   │
│   └── plugins/
│       ├── auto-session.lua   # Session save & restore manager
│       ├── cmp.lua            # Autocompletion engine (snippets, command, buffers)
│       ├── dap.lua            # Debug Adapter Protocol configurations
│       ├── editor.lua         # Visual enhancers (pairs, comments, multicursor)
│       ├── formatters.lua     # Code formatting via conform.nvim
│       ├── git.lua            # Git signs & diffview panel
│       ├── linters.lua        # Linter trigger via nvim-lint
│       ├── lsp.lua            # LSP config launcher & Mason tool manager
│       ├── neo-tree.lua       # File explorer side-panel
│       ├── telescope.lua      # Fuzzy finder
│       ├── testing.lua        # Neotest runner spec
│       ├── tools.lua          # ToggleTerm terminal, neogen, markdown preview
│       ├── tree-sitter.lua    # Tree-sitter highlighter
│       └── ui.lua             # Appearance specs (themes, statusline, bufferline)
```

---

## Key Structural Features

1. **Centralized settings.lua**: 
   All language status toggles, UI colorscheme definitions, formatting rules, and debug toggles are kept in a single file (`lua/config/settings.lua`).
2. **Language Specification Layer (`lua/languages/`)**:
   Instead of writing code across 5 files to add support for a language, a single language specification file (like `python.lua`) completely declares LSPs, linters, formatters, DAP configurations, test runners, and tools to install. The `languages/init.lua` orchestrator aggregates them and registers them automatically at runtime.
3. **Clean Plugin Directories**:
   Each spec file in `lua/plugins/` holds clean configurations that automatically hook into the language orchestrator. No redundant plugins, overlapping toggleterm files, or duplicate mason configs exist.
4. **Standard Vim Keymaps**:
   Global keymaps are kept in `lua/core/keymaps.lua`, and buffer-local LSP keymaps are attached dynamically by `lua/lsp/keymaps.lua` only when an LSP client connects.
