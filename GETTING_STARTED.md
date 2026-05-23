# Getting Started Playbook: Neovim Workstation in Action

Follow this end-to-end guide to launch, verify, and test your newly redesigned Neovim workstation.

---

## Step 1: Launch Neovim & Install Dependencies

Open a terminal and navigate to any of your project directories (or a new test folder), then launch Neovim:

```bash
nvim test_app.py
```

### What happens automatically:
1. **Lazy.nvim** boots up.
2. **Mason Tool Installer** triggers in the background. It reads your enabled modules and automatically starts downloading all required LSPs, formatters, linters, and debuggers (such as `pyright`, `ruff`, `mypy`, `debugpy`, etc.).

---

## Step 2: Monitor Installation Progress

To see what Mason is doing:
1. Inside Neovim, type:
   ```vim
   :Mason
   ```
2. You will see a list of tools. You can watch as Mason installs them one by one. Once complete, they will all show a green checkmark (`✓`).
3. Close the Mason panel by pressing `q`.

---

## Step 3: Verify Setup Diagnostics

Make sure everything is healthy:
1. Type:
   ```vim
   :checkhealth
   ```
2. Scroll down to review the reports for `lazy`, `treesitter`, `lspconfig`, `mason`, `conform`, `nvim-lint`, and `dap`.
3. If everything looks good, press `:q` to close the health report buffer.

---

## Step 4: Test First-Class Python Features

Let's test the IDE features in `test_app.py`.

### A. Autocomplete & Hover Docs
1. Switch to insert mode (`i`) and start typing:
   ```python
   import os
   
   def calculate_sum(first_number: int, second_number: int) -> int:
       """Adds two numbers."""
       return first_number + second_number
   ```
2. Notice the autocomplete card popping up. It displays suggestions with clean icons (using `lspkind`).
3. Press `gd` (Go to Definition) while hovering over `os` or a local function to jump to its source.
4. Press `K` while hovering over `calculate_sum` to view its type signatures and docstrings in a floating window.

### B. Formatting & Linting on Save
1. Write some poorly formatted code and add an unused import:
   ```python
   import sys # unused import
   def  bad_spacing(x,y):
     return x+y
   ```
2. Save the file (`:w`).
3. ** Ruff Format** will clean up the spacing instantly.
4. ** Ruff Check** will underline the unused import `sys` as a warning.
5. Move your cursor to the warning and press `<leader>d` to view the diagnostic description. Press `<leader>ca` to trigger a code action to automatically remove the unused import.

---

## Step 5: Test the Interactive Test Runner (Neotest)

1. Append a quick test to your file:
   ```python
   def test_addition():
       assert calculate_sum(2, 3) == 5
   ```
2. Place your cursor on the line containing `def test_addition():`.
3. Press `<leader>tn` (Test Nearest). This runs pytest in the background.
4. You will see a green checkmark or red cross appear in the gutter.
5. Press `<leader>ts` (Test Summary) to toggle the right-hand test explorer sidebar.
6. Press `<leader>to` (Test Output) to inspect the output console if a test fails.

---

## Step 6: Test the Debugger (DAP)

1. Move your cursor to `return first_number + second_number` inside `calculate_sum`.
2. Press `<leader>db` (Debug Breakpoint). A red `●` will appear in the gutter.
3. Add a call to trigger your function at the bottom:
   ```python
   if __name__ == "__main__":
       calculate_sum(10, 20)
   ```
4. Save the file and press `<leader>dc` (Debug Continue).
5. The debugger UI will open automatically, displaying variables, watches, breakpoints, and the terminal console.
6. Press `<leader>ds` to Step Over lines.
7. Hover over `first_number` and press `K` to view its current runtime value.
8. Press `<leader>dq` to terminate the debugger and close the UI.

---

## Step 7: Test UI Panels & Utilities

- **Code Outline Sidebar**: Press `<leader>o` to toggle the `aerial.nvim` structural panel showing your classes and methods.
- **Floating Terminal**: Press `<leader>t` (or `<C-\>`) to open an overlay terminal. Type commands, and press `jk` to exit terminal mode, then `<leader>t` to hide it.
- **Git Blame**: Hover over any line that has been modified and committed. The statusline or the end of the line will show a subtle blame message. Press `<leader>hb` to view full commit details.
- **Git Diff Workspace**: Run `:DiffviewOpen` or press `<leader>gd` to open a full review panel showing modified files.
