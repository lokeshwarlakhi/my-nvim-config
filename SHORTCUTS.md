---
name: Keyboard Shortcuts Reference
description: Complete categorized keymaps and workflows
---

# ⌨️ KEYBOARD SHORTCUTS REFERENCE

Complete searchable guide to all keybindings organized by workflow.

---

## 🚀 Quick Start: Most Important 10 Keymaps

These 10 keymaps will handle 80% of your workflow:

```
Leader Key: <space>

<space>ff   Find files in project
<space>fg   Live grep (search text)
<space>ca   Code actions (quick fixes, refactor)
gd          Go to definition
K           Hover documentation
<space>rn   Rename symbol
<space>lf   Format file
:q          Quit
:w          Save
<space>n    Next buffer
```

---

## 📋 Navigation & Finding

### File Finding
```
<leader>ff  Find files (Telescope)
<leader>fg  Live grep - search text in project
<leader>fb  Open buffer (recent files)
<leader>fs  Buffer fuzzy search (current file)
<leader>fh  Help tags (documentation)

<leader>ft  Grep in file explorer selection
<leader>fo  Document symbols (in current file)
<leader>fS  Workspace symbols (search all symbols)
```

### Code Navigation
```
gd          Go to definition
gD          Go to declaration
gi          Go to implementation
gt          Go to type definition
gr          Go to references (show where used)

<leader>li  Incoming calls (functions that call this)
<leader>lo  Outgoing calls (functions this calls)

[d          Previous diagnostic/error
]d          Next diagnostic/error
```

### Window & Split Management
```
<leader>sv  Split vertical (vsplit)
<leader>sh  Split horizontal (split)
<leader>se  Make splits equal size
<leader>sx  Close split
<leader>sj  Decrease split height
<leader>sk  Increase split height
<leader>sl  Increase split width
<leader>sh  Decrease split width

<C-h>       Move to left split
<C-j>       Move to down split
<C-k>       Move to up split
<C-l>       Move to right split
```

### Buffer Management
```
<leader>n   Next buffer
<leader>p   Previous buffer
<leader>x   Close buffer (delete)
<leader>w   Save buffer
<leader>ww  Save all buffers
```

### File Explorer (Neo-tree)
```
<leader>e   Toggle file explorer
<C-n>       Show file explorer (focused)

Within Explorer:
H           Toggle hidden files
.           Set current folder as root
<bs>        Navigate up to parent
```

---

## 🧠 LSP & Code Intelligence

### Information & Documentation
```
K           Hover documentation (shows type, docstring)
<C-k>       Signature help (in insert mode)
<leader>d   Show diagnostic at cursor

[d          Jump to previous error/warning
]d          Jump to next error/warning
```

### Refactoring & Code Actions
```
<leader>rn  Rename symbol (all occurrences)
<leader>ca  Code actions (context menu)
<leader>co  Organize imports
<leader>cf  Fix diagnostic (quick fix)
<leader>lf  Format document

v <leader>lf Format selection (in visual mode)
```

### Symbols & Outline
```
<leader>fs  Document symbols (show all in file)
<leader>fS  Workspace symbols (search entire project)
<leader>fm  Methods/functions in file
```

### Workspace Management
```
<leader>wa  Add folder to workspace
<leader>wr  Remove folder from workspace
<leader>wl  List all workspace folders
```

---

## 🐛 Debugging (DAP)

*Debug keymaps added when debug adapter is available*

```
<leader>db  Toggle breakpoint at cursor
<leader>dc  Continue execution
<leader>ds  Step over (execute current line)
<leader>di  Step into (go into function)
<leader>do  Step out (exit current function)

<leader>dw  Show watch/expressions window
<leader>dt  Show stack trace
<leader>dr  Show registers
<leader>dR  Restart debugger
<leader>dq  Quit debugger

:BreakpointToggle      Toggle at cursor
:BreakpointConditional Set conditional breakpoint
:BreakpointLogpoint    Set logpoint (logs instead of stopping)
```

---

## 🧪 Testing

*Requires: neotest plugin*

```
<leader>tn  Test nearest (test under cursor)
<leader>tf  Test current file
<leader>ta  Test all (run entire suite)
<leader>ts  Test summary (show results)
<leader>tw  Watch tests (re-run on save)
<leader>tq  Quit test runner
```

---

## 📝 Editing

### Basic Editing
```
i           Insert mode (before cursor)
a           Append mode (after cursor)
o           Open new line below
O           Open new line above
jk          Exit insert mode (custom)

<C-h>       Delete previous character (insert)
<C-j>       Move line down (insert)
<C-k>       Move line up (insert)

dd          Delete line
yy          Copy line
p           Paste after
P           Paste before
v           Visual mode (select)
```

### Text Objects & Motions
```
w           Next word start
b           Previous word start
e           Next word end
%           Jump to matching bracket

t<char>     Till character
f<char>     Find character
T<char>     Till backward
F<char>     Find backward

>           Indent
<           Unindent
=           Auto-indent
```

### Commenting
```
gcc         Toggle comment (line)
gc          Toggle comment (visual selection)

gcw         Comment word
gcs         Comment sentence
```

### Autopairs & Brackets
```
(           Insert (, automatically adds )
{           Insert {, automatically adds }
[           Insert [, automatically adds ]

<M-e>       Fast wrap selection (wrap with bracket)
```

---

## 🔍 Searching

### Find & Replace
```
/           Find (forward)
?           Find (backward)
n           Next match
N           Previous match
*           Find word under cursor (forward)
#           Find word under cursor (backward)

:s/old/new/g    Replace in line
:%s/old/new/g   Replace in file
:s/old/new/     Replace with confirmation
```

### Highlighting
```
<leader>u   Clear search highlight

# Automatic highlighting
- Reference highlighting (when hovering on symbol)
- Incremental search highlighting
- LSP semantic highlighting (if supported)
```

---

## 📋 Terminal Integration

```
<leader>th  Open terminal (horizontal split)
<leader>tv  Open terminal (vertical split)
<leader>tt  Open terminal (new tab)
<leader>t   Toggle terminal (toggleterm)

jk          Exit terminal mode
```

---

## 🎨 UI & Appearance

### Tabs
```
<leader>to  Open new tab
<leader>tx  Close current tab
<leader>tn  Next tab
<leader>tp  Previous tab
```

### General
```
<leader>qq  Quit without saving
<leader>wq  Save and quit
```

---

## 🔧 Command Mode

Common commands to type with `:` prefix:

```
:Mason              Open tool installer
:Lazy               Plugin manager UI
:LspInfo            Show LSP status
:LspRestart         Restart LSP servers
:Telescope          Fuzzy finder
:Neotree            File explorer

:set number         Show line numbers
:set nonumber       Hide line numbers
:set relativenumber Relative line numbers

:Format             Format buffer (conform)
:Lint               Lint buffer

:help               Open help
:q                  Quit
:wq                 Save and quit
:q!                 Quit without save
:w                  Save
:wa                 Save all
:!command           Run shell command
```

---

## 🏃 Common Workflows

### Edit a File Quickly

1. `<leader>ff` → Find file
2. Edit the file
3. `<leader>lf` → Format
4. `:w` → Save

### Find & Replace

1. `<leader>fg` → Live grep (find text)
2. When in grep results: can open files
3. `:s/old/new/g` → Replace in current buffer

### Debug a Function

1. `<leader>db` → Set breakpoint at problem line
2. `:!python script.py` → Run your script
3. Debugger pauses at breakpoint
4. `K` → Hover to see variable values
5. `<leader>ds` → Step over to next line

### Rename a Symbol Safely

1. Move cursor to symbol name
2. `<leader>rn` → Rename
3. Type new name
4. Press Enter
5. All occurrences updated automatically ✓

### Format Entire Project

```
<leader>fa  Format all Python files (LSP)
# Or use:
:!black .   Format with Black
```

### Add Tests While Coding

1. Write function
2. `<leader>tn` → Run test under cursor (auto-discovers)
3. Watch fails
4. `<leader>tw` → Watch mode (auto re-run on save)
5. Fix code
6. Tests pass automatically ✓

---

## 🌐 Multi-File Operations

### Working Across Files
```
gd          Go to definition (even in other files!)
gr          Show all references across project
<leader>ca  Code action (may involve multiple files)
<leader>rn  Rename across entire project
```

### Project-Wide Tasks
```
<leader>fg  Live grep (search entire project)
<leader>fS  Workspace symbols (find anything)
<leader>ta  Run all tests (project-wide)
<leader>lf  Format all open buffers
```

---

## 🎯 Tips & Tricks

### Repeat Last Action
```
.           Repeat last normal mode command
@:          Repeat last command
@@          Repeat last macro
```

### Quickfix List (Errors)
```
:copen      Open quickfix list
:ccl        Close quickfix list
:cn         Next error
:cp         Previous error
:cc 3       Go to error #3
```

### Macros
```
qa          Record macro to register 'a'
...         Do actions...
q           Stop recording
@a          Play macro from register 'a'
@@          Repeat last macro
```

### Marks
```
ma          Mark current position as 'a'
'a          Jump to mark 'a'
`a          Jump to exact column of mark 'a'
:marks      Show all marks
```

---

## 🔧 Customization

### How to Add Your Own Keymap

Edit `lua/core/keymaps.lua`:

```lua
-- Add this to define a custom keymap:
utils.keymap("n", "<leader>xx", ":MyCommand<CR>", {
  desc = "My custom command"
})
```

### How to Change a Keymap

Find the keymap in relevant file:
- `lua/core/keymaps.lua` - Global keymaps
- `lua/lsp/keymaps.lua` - LSP keymaps  
- `lua/navigation/keymaps.lua` - Navigation keymaps

Edit the mapping and reload config:
```
:so ~/.config/nvim/init.lua
```

---

## 📚 Learning Path

### Day 1 - Essential Navigation
Master these first:
1. `<space>ff` - Find files
2. `<space>fg` - Search text
3. `gd` - Go to definition
4. `K` - Hover help

### Day 2 - Editing & Formatting
1. Code actions `<space>ca`
2. Rename `<space>rn`
3. Format `<space>lf`
4. Comments `gcc`

### Day 3 - Advanced Features
1. References `gr`
2. Symbols `<space>fs`
3. Debug `<space>db`
4. Tests `<space>tn`

### Beyond - Power User Mode
1. Macros and marks
2. Quickfix list
3. Advanced text objects
4. Custom workflows

---

## 🆘 Troubleshooting

### Keymap Not Working

1. Check if plugin is loaded: `:Lazy`
2. Check if mapped: `:map <leader>xx`
3. Try calling directly: `:call MyFunction()`

### Too Many Keymaps to Remember

- Most used: ~15 keymaps (master these)
- Common: ~50 keymaps (learn gradually)
- Rare: ~100+ keymaps (look up as needed)

### Want Different Keymaps

Edit the keymap files, restart Neovim:
```vim
:so ~/.config/nvim/init.lua
```

---

## 📞 Help Resources

```
:help keymaps        Help on keybindings
:help lsp            LSP documentation
:help telescope      Telescope documentation

# Online
:h intro             Start Neovim help
:h quickref          Quick reference
:Telescope help_tags Search help tags
```

---

**Last Updated**: May 2026  
**Neovim Version**: 0.9+

---
