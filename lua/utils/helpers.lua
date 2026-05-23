-- ============================================================================
-- UTILITY HELPERS MODULE
-- ============================================================================
-- Common functions used throughout the configuration
-- Purpose: DRY (Don't Repeat Yourself) for common patterns
--
-- Usage:
--   local utils = require("utils.helpers")
--   utils.keyset("n", "<leader>ff", ":Telescope find_files<CR>")
--   utils.safe_require("my_plugin")
--
-- ============================================================================

local M = {}

-- ============================================================================
-- KEYMAP UTILITIES
-- ============================================================================

--- Set a keymap with consistent options
---@param mode string | Mode ("n", "i", "v", "c", "t")
---@param lhs string | Left-hand side (keys to map)
---@param rhs string | function | Right-hand side (action)
---@param opts table | Optional: { desc = "...", noremap = true, ... }
function M.keymap(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

--- Set multiple keymaps at once
---@param keymaps table | Array of {mode, lhs, rhs, opts}
function M.keymaps(keymaps)
  for _, map in ipairs(keymaps) do
    M.keymap(map[1], map[2], map[3], map[4] or {})
  end
end

-- ============================================================================
-- SAFE REQUIRE UTILITIES
-- ============================================================================

--- Safely require a module, return nil on error
---@param module string | Module path
---@return table | nil
function M.safe_require(module)
  local ok, result = pcall(require, module)
  if not ok then
    vim.notify("Failed to load module: " .. module .. "\n" .. result, vim.log.levels.WARN)
    return nil
  end
  return result
end

--- Require with error handling and optional callback
---@param module string | Module path
---@param on_success function | Callback on successful load
---@param on_error function | Callback on error (optional)
function M.require_with_callback(module, on_success, on_error)
  local ok, result = pcall(require, module)
  if ok then
    if on_success then
      on_success(result)
    end
    return result
  else
    if on_error then
      on_error(result)
    else
      vim.notify("Failed to load: " .. module, vim.log.levels.WARN)
    end
    return nil
  end
end

-- ============================================================================
-- COMMAND UTILITIES
-- ============================================================================

--- Create a custom command
---@param name string | Command name
---@param command string | function | Command implementation
---@param opts table | Optional command options
function M.command(name, command, opts)
  local options = {}
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_create_user_command(name, command, options)
end

--- Create multiple commands
---@param commands table | Array of {name, command, opts}
function M.commands(commands)
  for _, cmd in ipairs(commands) do
    M.command(cmd[1], cmd[2], cmd[3] or {})
  end
end

-- ============================================================================
-- AUTOCOMMAND UTILITIES
-- ============================================================================

--- Create an autocommand
---@param event string | string[] | Event(s) to trigger on
---@param callback function | Callback function
---@param opts table | Optional: {group, pattern, buffer, desc}
function M.autocmd(event, callback, opts)
  local options = {
    callback = callback,
  }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_create_autocmd(event, options)
end

--- Create an autocommand group
---@param group_name string | Group name
---@param opts table | Autocmd options
function M.augroup(group_name, opts)
  vim.api.nvim_create_augroup(group_name, { clear = true })
  if opts then
    for event, callback in pairs(opts) do
      vim.api.nvim_create_autocmd(event, {
        group = group_name,
        callback = callback,
      })
    end
  end
end

-- ============================================================================
-- BUFFER UTILITIES
-- ============================================================================

--- Get current buffer number
---@return number
function M.current_buf()
  return vim.api.nvim_get_current_buf()
end

--- Get current buffer name
---@return string
function M.current_buf_name()
  return vim.api.nvim_buf_get_name(M.current_buf())
end

--- Get current buffer filetype
---@return string
function M.current_filetype()
  return vim.bo.filetype
end

--- Check if buffer has unsaved changes
---@return boolean
function M.buf_modified()
  return vim.bo.modified
end

-- ============================================================================
-- FILE UTILITIES
-- ============================================================================

--- Check if file exists
---@param path string | File path
---@return boolean
function M.file_exists(path)
  return vim.fn.filereadable(path) == 1
end

--- Check if path is a directory
---@param path string | Directory path
---@return boolean
function M.is_directory(path)
  return vim.fn.isdirectory(path) == 1
end

--- Get project root by looking for marker files
---@param markers table | Marker files to search for ({".git", "package.json", ...})
---@return string | Project root path or current directory
function M.get_project_root(markers)
  markers = markers or { ".git", "pyproject.toml", "package.json", ".root" }
  local root_files = vim.fs.find(markers, { upward = true })
  if root_files and #root_files > 0 then
    return vim.fs.dirname(root_files[1])
  end
  return vim.fn.getcwd()
end

-- ============================================================================
-- TABLE UTILITIES
-- ============================================================================

--- Merge two tables
---@param t1 table | First table
---@param t2 table | Second table
---@return table | Merged table
function M.merge_tables(t1, t2)
  return vim.tbl_extend("force", t1 or {}, t2 or {})
end

--- Check if value exists in table
---@param tbl table | Table to search
---@param value any | Value to find
---@return boolean
function M.table_contains(tbl, value)
  for _, v in ipairs(tbl) do
    if v == value then
      return true
    end
  end
  return false
end

--- Get table keys
---@param tbl table | Table to get keys from
---@return table | Array of keys
function M.table_keys(tbl)
  local keys = {}
  for k in pairs(tbl) do
    table.insert(keys, k)
  end
  return keys
end

-- ============================================================================
-- NOTIFICATION UTILITIES
-- ============================================================================

--- Show info notification
---@param message string | Message to display
function M.info(message)
  vim.notify(message, vim.log.levels.INFO)
end

--- Show warning notification
---@param message string | Message to display
function M.warn(message)
  vim.notify(message, vim.log.levels.WARN)
end

--- Show error notification
---@param message string | Message to display
function M.error(message)
  vim.notify(message, vim.log.levels.ERROR)
end

--- Show success notification
---@param message string | Message to display
function M.success(message)
  vim.notify(message, vim.log.levels.INFO, { title = "✓" })
end

-- ============================================================================
-- SYSTEM UTILITIES
-- ============================================================================

--- Check if executable exists in PATH
---@param executable string | Executable name
---@return boolean
function M.executable_exists(executable)
  return vim.fn.executable(executable) == 1
end

--- Get home directory path
---@return string
function M.get_home()
  return os.getenv("HOME")
end

--- Get OS type
---@return string | "Linux" | "Darwin" | "Windows"
function M.get_os()
  if vim.fn.has("win32") == 1 then
    return "Windows"
  elseif vim.fn.has("mac") == 1 then
    return "Darwin"
  else
    return "Linux"
  end
end

-- ============================================================================
-- PERFORMANCE UTILITIES
-- ============================================================================

--- Measure execution time of a function
---@param fn function | Function to measure
---@param name string | Name for logging
---@return number | Execution time in ms
function M.measure_time(fn, name)
  local start = vim.loop.hrtime()
  fn()
  local elapsed_ms = (vim.loop.hrtime() - start) / 1000000
  if name then
    print(string.format("%s: %.2f ms", name, elapsed_ms))
  end
  return elapsed_ms
end

-- ============================================================================
-- DIAGNOSTIC UTILITIES
-- ============================================================================

--- Format diagnostic message for display
---@param diagnostic table | LSP diagnostic
---@return string | Formatted message
function M.format_diagnostic(diagnostic)
  return string.format("[%s] %s", diagnostic.source or "LSP", diagnostic.message)
end

--- Get diagnostics for current line
---@return table | Array of diagnostics
function M.get_line_diagnostics()
  local line = vim.api.nvim_win_get_cursor(0)[1] - 1
  return vim.diagnostic.get(0, { lnum = line })
end

return M
