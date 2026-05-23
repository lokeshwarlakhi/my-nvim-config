# Refactoring Migration Notes

This document highlights the key changes in keymaps, behaviors, and workflows you should be aware of after this cleanup.

---

## 1. Window Splits Navigation vs. Moving Lines

* **Before**: `<C-j>` and `<C-k>` were bound to both **Move Lines Down/Up** and **Switch Split Window (Down/Up)**. Because the split navigation mapping was loaded last, the move lines feature was broken and unreachable in normal mode.
* **Now**: 
  * **Move Lines** (normal, insert, and visual modes) is now mapped to Alt+j (`<A-j>`) and Alt+k (`<A-k>`), matching standard IDE behaviors (like VSCode).
  * **Window Splits Navigation** (normal mode) now fully responds to `<C-j>` (go to lower split) and `<C-k>` (go to upper split) without conflicts.

---

## 2. Formatting Document Shortcut

* **Before**: `<leader>lf` was bound to both `conform.nvim` (runs custom formatters like Ruff) and the raw LSP buffer formatter (run via on-attach config). The LSP attachment overrode conform, causing slower or missing formatters.
* **Now**: The raw LSP formatting mapping is removed. Pressing `<leader>lf` (or saving the file) will execute `conform.nvim` directly, ensuring your configured formatters (such as `ruff_format` for Python or `stylua` for Lua) are reliably triggered.

---

## 3. Safely Closing Buffers & Splits

* **Before**: `<leader>x` ran a raw command pipeline (`bp | sp | bn | bd`) to close files without breaking split layouts, but it would loop and split terminal buffers indefinitely because terminal jobs cannot be deleted without a force flag.
* **Now**: `<leader>x` runs a custom Lua script:
  * For **terminal** buffers, it runs `bwipeout!` to terminate and close the terminal split instantly.
  * For **files**, it shifts pane focus before deleting the buffer, preserving layout splits, and prompts to save changes if modified.
