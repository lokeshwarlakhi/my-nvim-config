# Neovim Language Expansion Guide

This guide explains how to add support for a new programming language to your Neovim environment using the **Single-File Language Specification** architecture.

---

## 1. The Language Expansion Workflow

Adding a new language is extremely simple. You do not need to scatter configurations across formatting files, linting files, and LSP directories. You only need to perform three steps:

```
1. Create a language spec file: lua/languages/<my_lang>.lua
                         │
                         ▼
2. Enable it in settings: lua/config/settings.lua
                         │
                         ▼
3. Restart Neovim! (Mason installs tools automatically)
```

---

## 2. Step-by-Step Example: Adding a Language (e.g. SQL)

Let's walk through how you would add support for SQL using `sql-language-server`, `sqlfluff` for linting, and `sqlformat` for formatting.

### Step 1: Create the Language Specification File
Create a new file: `lua/languages/sql.lua` and define the tool maps:

```lua
-- lua/languages/sql.lua
local sql_spec = {
  -- 1. LSP Configuration
  lsp = {
    server = "sqlls", -- Mason LSP server identifier
    config = {
      settings = {
        sqlls = {
          connections = {
            -- Connection parameters for SQL completions
          }
        }
      }
    }
  },
  
  -- 2. Formatter Configuration (Conform)
  formatters = {
    sql = { "sqlformat" },
  },
  formatter_configs = {
    sqlformat = {
      command = "sqlformat",
      args = { "--reindent", "--keywords", "upper", "-" },
      stdin = true,
    }
  },
  
  -- 3. Linter Configuration (Nvim-lint)
  linters = {
    sql = { "sqlfluff" },
  },
  linter_configs = {
    sqlfluff = {
      cmd = "sqlfluff",
      args = { "lint", "--format", "json", "-" },
      stdin = true,
      stream = "stdout",
      parser = function(...)
        return require("lint.parser").from_json(...)
      end
    }
  },
  
  -- 4. Mason Tools to install automatically
  tools = {
    "sql-language-server", -- LSP
    "sqlformat",           -- Formatter
    "sqlfluff",            -- Linter
  }
}

return sql_spec
```

### Step 2: Enable the Language in Settings
Open `lua/config/settings.lua` and register your new module under `M.languages`:

```diff
 M.languages = {
   python = true,
   go = true,
   rust = true,
   typescript = true,
   devops = true,
+  sql = true,
 }
```

### Step 3: Restart Neovim
Once saved, restart Neovim. The orchestrator will read `lua/languages/sql.lua`, compile your settings, and launch `mason-tool-installer`. 

You will see status notifications indicating that `sql-language-server`, `sqlformat`, and `sqlfluff` are being downloaded and configured automatically.

---

## 3. Reference: Specification Schema

Every file under `lua/languages/` must return a Lua table adhering to this structure:

```lua
return {
  -- LSP setup. Can define single server or multiple servers
  lsp = {
    server = "server_name", -- (Optional) string
    config = { ... },       -- (Optional) lspconfig table overrides
    
    -- OR for bundle modules containing multiple LSPs:
    servers = { "server1", "server2" },
    configs = {
      server1 = { ... },
      server2 = { ... },
    }
  },
  
  -- Formatters mapping (filetype to list of formatters)
  formatters = {
    filetype_name = { "formatter1", "formatter2" }
  },
  formatter_configs = {
    formatter1 = {
      command = "binary_name",
      args = { ... },
      stdin = true/false
    }
  },
  
  -- Linters mapping (filetype to list of linters)
  linters = {
    filetype_name = { "linter1" }
  },
  linter_configs = {
    linter1 = {
      cmd = "binary_name",
      args = { ... },
      stdin = true/false,
      stream = "stdout"/"stderr",
      parser = function(...) ... end
    }
  },
  
  -- DAP Debugger setup
  dap = {
    adapters = {
      adapter_name = { ... } -- DAP adapter configuration
    },
    configurations = {
      filetype_name = {
        { ... } -- DAP launch/attach configuration items
      }
    }
  },
  
  -- Neotest adapters
  testing = {
    adapters = {
      ["adapter-plugin-name"] = { ... } -- Configuration passed to adapter()
    }
  },
  
  -- Mason tools list
  tools = {
    "tool-name-1",
    "tool-name-2",
  }
}
```
