-- ============================================================================
-- DEVOPS & CLOUD LANGUAGES MODULE
-- ============================================================================
-- Purpose: Specification for YAML, Docker, Terraform, Bicep, Bash, JSON, Markdown.
-- ============================================================================

local devops_spec = {
  -- LSPs to configure
  lsp = {
    -- We can only define a single lsp.server inside the language loader per file,
    -- but devops contains multiple LSPs! Let's handle loading additional servers
    -- dynamically by listing them in a custom field. We'll modify languages/init.lua
    -- to support registering multiple servers if defined in a list!
    -- This is a great extension of our orchestrator.
    servers = {
      "dockerls",
      "yamlls",
      "bashls",
      "terraformls",
      "bicep",
      "jsonls",
      "marksman",
    },
    
    -- LSP-specific overrides
    configs = {
      yamlls = {
        settings = {
          yaml = {
            schemas = {
              ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.yaml",
            },
            format = { enable = true },
          }
        }
      },
      bicep = {
        -- Bicep-specific configs if any
      }
    }
  },
  
  -- Formatters
  formatters = {
    sh = { "shfmt" },
    terraform = { "terraform_fmt" },
    yaml = { "prettier" },
    json = { "prettier" },
    markdown = { "prettier" },
  },
  formatter_configs = {
    shfmt = {
      command = "shfmt",
      args = { "-i", "2", "-ci" },
      stdin = true,
    },
    terraform_fmt = {
      command = "terraform",
      args = { "fmt", "-" },
      stdin = true,
    }
  },
  
  -- Linters
  linters = {
    dockerfile = { "hadolint" },
    yaml = { "yamllint" },
    sh = { "shellcheck" },
    markdown = { "markdownlint" },
  },
  linter_configs = {},
  
  -- Mason tools list
  tools = {
    "dockerfile-language-server",
    "yaml-language-server",
    "bash-language-server",
    "terraform-ls",
    "bicep-lsp",
    "json-lsp",
    "marksman",
    "shfmt",
    "hadolint",
    "yamllint",
    "shellcheck",
    "markdownlint",
  }
}

return devops_spec
