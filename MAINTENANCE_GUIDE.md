# Neovim Configuration Maintenance Guide

This document describes how to update your workstation plugins, manage Mason dependencies, check editor health, profile startup speeds, and rollback changes in case of breaking package updates.

---

## 1. Package Updates & Maintenance

### A. Updating Plugins (Lazy.nvim)
All plugins are locked in `lazy-lock.json` to prevent updates from breaking your configuration. To manage updates:
- Open Neovim and run `:Lazy` to open the package UI.
- Press `U` to check for updates.
- Press `X` to run clean updates on outdated plugins.
- Press `S` to sync and install missing packages.

### B. Updating LSPs, Formatters, & Linters (Mason)
- Open the Mason UI by running `:Mason`.
- Press `u` inside the UI to check for available updates on LSPs, linters, and formatters.
- Run `:MasonUpdate` to update all package managers and install newer versions of utilities globally.

### C. Updating Syntax Grammars (Treesitter)
- Running `:TSUpdate` will update all installed grammar parsers.
- If you run into weird highlight blocks, it is usually because Treesitter parser versions mismatch with your Neovim core runtime. Running `:TSUpdate` fixes this.

---

## 2. Diagnostics & Health Checks

Before debugging complex problems, check Neovim's built-in self-test diagnostics:

```vim
:checkhealth
```

This runs structural testing reports on:
- Neovim configuration validity
- System clipboard utilities (`pbcopy`/`xclip`)
- Treesitter syntax installations
- LSP connections
- Provider utilities (Python provider, Node provider)
- Installed debuggers and formatters

---

## 3. Startup Performance Profiling

If Neovim begins to feel sluggish or slow to open:

1. **Lazy Profile Analyzer**:
   - Run `:Lazy profile` inside Neovim.
   - This opens an interactive checklist showing exactly how many milliseconds each plugin took to load, and what event triggered its initialization.
   - Check if any plugin is running synchronously (look for plugins without loading events or loaded with `lazy = false`).

2. **Check Startup Time**:
   - You can measure exactly how long Neovim takes to initialize by opening it from terminal with:
     ```bash
     nvim --startuptime startup.log
     ```
   - Inspect the generated `startup.log` file. The final line shows the total loading duration in milliseconds.

---

## 4. Rollback & Backup Strategy

### A. Commit Lockfile (Recommended)
The `lazy-lock.json` file in the root of your configuration folder stores the exact Git commit SHA of every plugin.
- Keep `lazy-lock.json` version-controlled in your Git repo.
- If an update breaks your configuration, discard changes in your local lockfile:
  ```bash
  git checkout lazy-lock.json
  ```
- Then open Neovim and run `:Lazy restore`. This automatically rolls back every plugin to its last working version!

### B. Dynamic Backups
Before making major adjustments to your configuration files, create a quick backup:
```bash
# Create a backup archive in your home folder
tar -czf ~/nvim-config-backup.tar.gz -C ~/.config nvim
```

To restore the backup:
```bash
# Remove current config and restore
rm -rf ~/.config/nvim
tar -xzf ~/nvim-config-backup.tar.gz -C ~/.config
```

---

## 5. Troubleshooting Common Issues

### "LSP client not starting"
1. Run `:LspInfo` in the buffer of the file. It will show if a client is configured for the current filetype and if it is active.
2. Run `:messages` to see if there are any startup logs or errors.
3. Check if the server binary is installed in Mason: run `:Mason` and ensure the server name (e.g. `pyright`) has a green checkmark.

### "Formatting not working on save"
1. Check if the formatter is active for the current filetype: run `:ConformInfo`.
2. Ensure you have the formatter installed in Mason.
3. Run `:FormatVerbose` to force format the current buffer and dump verbose execution trace logs to help pinpoint errors.
