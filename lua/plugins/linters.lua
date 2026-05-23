return {
  "mfussenegger/nvim-lint",
  event = "BufWritePost",
  config = function()
    require("lint").linters_by_ft = {
      python = { "ruff", "pylint" }, -- Python LINTERS (like VSCode Python extension)
      lua = { "luacheck" }, -- Lua LINTER
      javascript = { "eslint" }, -- JavaScript LINTER
      typescript = { "eslint" }, -- TypeScript LINTER
      javascriptreact = { "eslint" }, -- React JS
      typescriptreact = { "eslint" }, -- React TS
      json = { "jsonlint" }, -- JSON LINTER
      yaml = { "yamllint" }, -- YAML LINTER
      markdown = { "markdownlint" }, -- Markdown LINTER
      -- Add More Linters!!
    }

    -- Configure linters with VSCode-like settings
    require("lint").linters.ruff = {
      cmd = "ruff",
      args = {
        "--extend-select", "E,W,F", -- Include pycodestyle, pyflakes, and some ruff rules
        "--max-line-length", "88", -- Black-like line length
        "--ignore", "E501", -- Ignore line too long (handled by formatter)
      },
    }

    require("lint").linters.pylint = {
      cmd = "pylint",
      args = {
        "--disable", "C0114,C0115,C0116", -- Disable docstring warnings (like VSCode default)
        "--max-line-length", "100", -- VSCode Python default
      },
    }

    require("lint").linters.eslint = {
      args = {
        "--format", "json",
        "--stdin",
        "--stdin-filename", function() return vim.api.nvim_buf_get_name(0) end,
      },
    }

    -- Auto-lint on save
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })

    -- Also lint on buffer enter for immediate feedback
    vim.api.nvim_create_autocmd({ "BufEnter" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end
}
