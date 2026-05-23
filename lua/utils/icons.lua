-- ============================================================================
-- ICON DEFINITIONS
-- ============================================================================
-- Centralized icon definitions for consistent UI
-- Purpose: Single source of truth for all icons/symbols used throughout config
--
-- Usage:
--   local icons = require("utils.icons")
--   print(icons.diagnostics.error)  -- "✗"
--
-- ============================================================================

local M = {}

-- ============================================================================
-- DIAGNOSTIC ICONS
-- ============================================================================
M.diagnostics = {
  error = "✗",
  warning = "⚠",
  information = "ℹ",
  hint = "💡",
}

-- ============================================================================
-- SEPARATOR ICONS
-- ============================================================================
M.separators = {
  arrow_right = "▶",
  arrow_left = "◀",
  arrow_double_right = "»",
  arrow_double_left = "«",
  line_vertical = "│",
  line_horizontal = "─",
  corner_ul = "╔",
  corner_ur = "╗",
  corner_dl = "╚",
  corner_dr = "╝",
}

-- ============================================================================
-- STATUS / STATE ICONS
-- ============================================================================
M.status = {
  check = "✓",
  cross = "✗",
  circle_filled = "●",
  circle_empty = "○",
  square_filled = "■",
  square_empty = "□",
  pause = "⏸",
  play = "▶",
  stop = "⏹",
  debug = "🐛",
  watch = "👁",
  breakpoint = "●",
  logpoint = "◆",
}

-- ============================================================================
-- LANGUAGE ICONS (Nerd Font)
-- ============================================================================
M.languages = {
  python = "",
  lua = "",
  go = "",
  rust = "",
  javascript = "",
  typescript = "",
  react = "",
  java = "",
  kotlin = "",
  csharp = "",
  cpp = "",
  c = "",
  sql = "",
  bash = "",
  shell = "",
  zsh = "",
  vim = "",
  markdown = "",
  json = "",
  yaml = "",
  toml = "",
  dockerfile = "",
  terraform = "",
  bicep = "",
  kotlin = "",
}

-- ============================================================================
-- FILE ICONS (by extension)
-- ============================================================================
M.filetypes = {
  [".py"] = "",
  [".lua"] = "",
  [".go"] = "",
  [".rs"] = "",
  [".js"] = "",
  [".ts"] = "",
  [".tsx"] = "",
  [".jsx"] = "",
  [".java"] = "",
  [".sql"] = "",
  [".sh"] = "",
  [".bash"] = "",
  [".zsh"] = "",
  [".vim"] = "",
  [".md"] = "",
  [".json"] = "",
  [".yaml"] = "",
  [".yml"] = "",
  [".toml"] = "",
  [".Dockerfile"] = "",
  [".tf"] = "",
  [".bicep"] = "",
}

-- ============================================================================
-- GIT ICONS
-- ============================================================================
M.git = {
  added = "✓",
  modified = "~",
  deleted = "✗",
  renamed = "➜",
  untracked = "★",
  ignored = "◌",
  conflicted = "═",
  staged = "✓",
  unstaged = "✕",
  branch = "",
  tag = "",
  commit = "",
  stash = "⚑",
}

-- ============================================================================
-- UI ELEMENT ICONS
-- ============================================================================
M.ui = {
  search = "",
  file = "",
  folder = "",
  folder_open = "",
  folder_closed = "",
  document = "",
  lock = "",
  unlock = "",
  settings = "",
  gear = "⚙",
  gear_small = "⚙",
  calendar = "",
  clock = "",
  timer = "⏱",
  terminal = "",
  split_vertical = "⬌",
  split_horizontal = "⬊",
  expand = "✚",
  collapse = "✖",
  maximize = "□",
  minimize = "▬",
}

-- ============================================================================
-- TESTING ICONS
-- ============================================================================
M.testing = {
  passed = "✓",
  failed = "✗",
  skipped = "⊘",
  running = "⟳",
  pending = "◜",
  test = "🧪",
}

-- ============================================================================
-- MISC ICONS
-- ============================================================================
M.misc = {
  ellipsis = "…",
  dot = "•",
  bullet = "▸",
  star = "★",
  hourglass = "⏳",
  chevron_right = "❯",
  chevron_left = "❮",
  chevron_down = "▼",
  chevron_up = "▲",
}

return M
