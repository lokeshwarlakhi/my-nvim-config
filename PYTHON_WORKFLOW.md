# Python Development Workflow Guide

This document describes how to work in your premium Python development environment. It details virtualenv detection, package management (`uv`, `poetry`), debugging, testing, formatting, and linting pipelines.

---

## 1. Virtualenv & Environment Detection

Your environment automatically scans for virtualenvs in common locations (`.venv`, `venv`, `env`, `.env`) relative to the project root.

### A. Automatic Detection
When you open a Python file in a project folder, the statusline or `:LspInfo` will show the Python executable path being used by the LSP server (`pyright` or `basedpyright`). It automatically searches for the local virtualenv to resolve your packages correctly.

### B. Standard `uv` Workflow
`uv` is the recommended Python package manager (extremely fast, compatible with pip/poetry).
1. Initialize a project:
   ```bash
   uv init
   uv venv
   ```
2. Activate local environment:
   ```bash
   source .venv/bin/activate
   ```
3. Add packages:
   ```bash
   uv add requests fastapi uvicorn
   ```
4. Neovim will automatically pick up the virtualenv executable `venv/bin/python` for autocompletion, type checks, and debugger processes!

---

## 2. Code Formatting & Linting Pipeline

Every time you save a `.py` file, two things happen asynchronously:

```
[Save File]
    │
    ├─► [Conform] ──► Runs Ruff Format (async) ──► Re-styles code (indentation, imports)
    │
    └─► [Nvim-lint] ─► Runs Ruff Check + Mypy ───► Emits Diagnostics (underline errors)
```

- **Formatting**: Done by `ruff format` (matches Black conventions but executes 10-100x faster). You can force format with `<leader>lf` or `:Format`.
- **Linting**:
  - `ruff` highlights standard syntax lint errors (unused imports, undef variables) instantly.
  - `mypy` performs type safety analysis.
  - Hover on underlines and press `<leader>d` to view details in a rounded float window. Press `]d` and `[d` to jump between errors.

---

## 3. Asynchronous Test Suite (Neotest)

No need to jump back and forth to your terminal to run `pytest`. Your test runner is integrated into Neovim:

- **Run test under cursor**: Move your cursor inside a test function and press `<leader>tn`.
- **Run current file tests**: Press `<leader>tf`.
- **Run whole project suite**: Press `<leader>ta`.
- **Open test output inspector**: Press `<leader>to` (lets you see tracebacks and assertion errors in detail).
- **Watch tests**: Press `<leader>tw` to enter watch mode. Tests will run automatically every time you write changes to a python file.
- **Toggle summary panel**: Press `<leader>ts` to see a tree of tests and their passing/failing status in a right sidebar.

---

## 4. Debugger Workflows (DAP + debugpy)

Debugging is fully interactive, featuring graphical variables inspectors and code stepping:

### Standard Debugging Sequence:
1. **Set Breakpoint**: Move cursor to a line of interest and press `<leader>db`. A red `●` will appear in the gutter.
2. **Launch Session**: Press `<leader>dc` (Debug Continue).
   - This launches `debugpy`, boots the current file, and pauses execution on your breakpoint.
   - The Debugger UI will open automatically on the left and bottom showing: Variables (scopes), Watches, Call Stack, Breakpoints, and Terminal REPL.
3. **Step Through Code**:
   - Press `<leader>ds` to Step Over (execute current line).
   - Press `<leader>di` to Step Into (go inside function).
   - Press `<leader>do` to Step Out (exit function).
4. **Inspect Variables**:
   - Hover your cursor over any variable name and press `K`. The type and evaluated value will appear in a rounded window.
   - Values are also written inline as virtual text (`var = value`).
5. **Terminate Debugger**: Press `<leader>dq` to exit the session. The layout panels will close automatically.

---

## 5. AI Engineering & Modern Stacks

### fastapi & uvicorn:
To debug a running web application, create an launch configuration in your project root or start the debugger process by attaching to a running Python process ID.

### Docstring Generation (Neogen):
To document functions easily using NumPy standard docstring format:
- Move cursor onto a function signature line (e.g. `def my_func(a: int) -> str:`).
- Run `<leader>nc` (Neogen Code).
- It will inject a template where you can fill in parameter details using `<Tab>` jumps.
