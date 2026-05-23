# Workstation Keyboard Shortcuts Reference

This cheatsheet lists all available keybindings, categorized by development concerns.

**Leader Key**: `<space>` (spacebar)

---

## 1. Top 10 Essential Shortcuts

Master these first to handle 80% of your daily operations:

| Keymap | Description | Context |
|---|---|---|
| `<leader>ff` | Search for files in project | Normal |
| `<leader>fg` | Search for text in project (live grep) | Normal |
| `gd` | Go to definition of symbol | Normal (LSP) |
| `K` | Show hover documentation | Normal (LSP) |
| `<leader>ca` | Show code actions (quick-fixes, imports) | Normal (LSP) |
| `<leader>rn` | Rename symbol globally | Normal (LSP) |
| `<leader>lf` | Format current document | Normal / Visual |
| `<leader>e` | Toggle file explorer sidebar (Neo-tree) | Normal |
| `<leader>o` | Toggle code symbols outline (Aerial) | Normal |
| `jk` | Exit insert mode / terminal mode | Insert / Terminal |

---

## 2. File Finding & Fuzzy Search (Telescope)

| Keymap | Description |
|---|---|
| `<leader>ff` | Search for files by name in workspace |
| `<leader>fg` | Search for text strings across all project files |
| `<leader>fb` | List and search active editor buffers |
| `<leader>fs` | Fuzzy search text inside the current active file |
| `<leader>fh` | Search Neovim help documentation tags |
| `<leader>ft` | Find all TODO / FIXME comments in project |

---

## 3. Editor Navigation & Window Management

### Buffer Tabs
| Keymap | Description |
|---|---|
| `<leader>n` | Switch to next buffer tab |
| `<leader>p` | Switch to previous buffer tab |
| `<leader>x` | Close current buffer tab safely |

### Splitting and Window Sizing
| Keymap | Description |
|---|---|
| `<C-h>` / `<C-l>` | Move cursor to left / right window split |
| `<C-j>` / `<C-k>` | Move cursor to lower / upper window split |
| `<leader>sv` | Split window vertically |
| `<leader>sh` | Split window horizontally |
| `<leader>se` | Equalize size of all splits |
| `<leader>sx` | Close current window split |
| `<leader>sk` / `<leader>sj` | Increase / Decrease split window height |
| `<leader>s>` / `<leader>s<` | Increase / Decrease split window width |

### Code Navigation (LSP)
| Keymap | Description |
|---|---|
| `gd` | Jump to definition of symbol |
| `gD` | Jump to declaration |
| `gi` | Jump to implementation |
| `gr` | Show all references of symbol in quickfix list |
| `gt` | Jump to type definition |
| `[d` / `]d` | Jump to previous / next diagnostic warning or error |
| `<leader>d` | Open detailed diagnostic warning in a float window |

---

## 4. Code Refactoring & Manipulation

| Keymap | Description | Context |
|---|---|---|
| `<leader>rn` | Rename symbol globally across project | Normal |
| `<leader>ca` | Trigger LSP Code Actions (quick-fixes, imports) | Normal |
| `<leader>lf` | Format document or selection | Normal / Visual |
| `ysw<char>` | Surround word with character (e.g. `ysw"`) | Normal (Surround) |
| `ds<char>` | Delete surrounding character (e.g. `ds"`) | Normal (Surround) |
| `cs<old><new>`| Change surrounding character (e.g. `cs"'`) | Normal (Surround) |
| `gcc` | Toggle line comment | Normal |
| `gc` | Toggle visual selection comment | Visual |
| `<C-d>` | Select word under cursor to enter multicursor mode | Normal / Visual |
| `<leader>nc` | Generate docstring template | Normal (Neogen) |

---

## 5. Testing & Debugging (DAP + Neotest)

### Test Runner
| Keymap | Description |
|---|---|
| `<leader>tn` | Run nearest test |
| `<leader>tf` | Run current file test |
| `<leader>ta` | Run entire test suite |
| `<leader>to` | Open test execution output window |
| `<leader>ts` | Toggle visual test summary tree |
| `<leader>tw` | Toggle automatic test watch mode |

### Debugger
| Keymap | Description |
|---|---|
| `<leader>db` | Toggle debugger breakpoint on current line |
| `<leader>dc` | Launch debugger or continue running |
| `<leader>ds` | Step over next line |
| `<leader>di` | Step into function call |
| `<leader>do` | Step out of current function |
| `<leader>dr` | Restart debugger session |
| `<leader>dq` | Terminate debugger session |
| `<leader>du` | Toggle graphical debugger panels manually |

---

## 6. Git Version Control

| Keymap | Description |
|---|---|
| `]h` / `[h` | Jump to next / previous changed git hunk |
| `<leader>hs` | Stage current changed git hunk |
| `<leader>hr` | Reset current changed git hunk |
| `<leader>hp` | Preview hunk difference inline |
| `<leader>hb` | Show inline Git Blame for current line |
| `<leader>gd` | Open dynamic graphical Diffview layout |
| `<leader>gh` | Open commit history panel for current file |

---

## 7. Productivity & Markdown Tools

| Keymap | Description | Mode |
|---|---|---|
| `<leader>tm` | Toggle Markdown inline rendering (render-markdown.nvim) | Normal |
| `<leader>mp` | Toggle Markdown browser live preview (markdown-preview.nvim) | Normal |
