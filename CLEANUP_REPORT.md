# Neovim Codebase Cleanup Report

This report documents all the obsolete files, duplicate configurations, and empty folders that were safely cleaned up during the refactoring process.

---

## 1. Files Safely Removed

| File path | Category | Rationale for Removal |
| :--- | :--- | :--- |
| **`lua/lsp/man.txt`** | Obsolete Notes | Stale text notes outlining an outdated LSP architecture from previous refactoring phases. |
| **`lua/utils/icons.lua`** | Unused Abstraction | Entirely unimported file containing Nerd Font symbols. Other plugins configure their icons inline or via native setups. |
| **`lua/utils/helpers.lua`** | Over-Engineered Abstraction | 323 lines of wrapper functions (e.g., table manipulation, custom command wrappers, notification logs) that were completely unused except for one keymap wrapper. Replacing the keymap wrapper in `lsp/keymaps.lua` with native Neovim APIs made this helper file obsolete. |
| **`lua/plugins/terminal.lua`** | Duplicate Configuration | Redundant plugin specification for `akinsho/toggleterm.nvim`. A much richer and more detailed configuration is already present in `lua/plugins/tools.lua`. |
| **`lua/plugins/mason.lua`** | Duplicate Configuration | Redundant setup file for `williamboman/mason.nvim`. Mason is already fully integrated and configured in the main `lua/plugins/lsp.lua` file. |

---

## 2. Empty Folders Cleaned Up

The following directories were leftover folders from previous module splits that contained no active configuration code:

* `lua/dap/` (including `lua/dap/adapters/`)
* `lua/editor/`
* `lua/formatting/`
* `lua/git/`
* `lua/linting/`
* `lua/navigation/`
* `lua/testing/`
* `lua/tools/`
* `lua/ui/`

---

## 3. Keymap & API Simplifications

* **Standardized LSP Keymaps**: In [keymaps.lua](file:///Users/lokeshwarlakhi/.config/nvim/lua/lsp/keymaps.lua), we replaced the custom `utils.keymap` wrapper with a concise, local `map` function calling standard `vim.keymap.set`. This removed the dependency on `helpers.lua` and made the bindings easier to read and maintain.
* **Consolidated Formatting Provider**: Removed the `<leader>lf` LSP formatting mapping from `lsp/keymaps.lua` to prevent it from overriding the `conform.nvim` formatter setup. All formatting is now reliably managed via `conform.nvim`.
* **Resolved Keymap Conflicts**: Changed the **Move Line** mapping in [keymaps.lua](file:///Users/lokeshwarlakhi/.config/nvim/lua/core/keymaps.lua) from `<C-j>`/`<C-k>` to `<A-j>`/`<A-k>` (Alt+j / Alt+k). This frees up Ctrl+j and Ctrl+k for split-pane switching, matching standard Neovim window navigation rules.
