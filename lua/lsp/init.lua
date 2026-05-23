local servers = require("lsp.servers")
local on_attach = require("lsp.keymaps")

-- Setup mason-lspconfig (INSTALL LSPs)
require("mason-lspconfig").setup({
  ensure_installed = servers.list,
})
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")


for _, server in ipairs(servers.list) do
  local ok, settings = pcall(require, "lsp.settings." .. server)

  vim.lsp.config(server, {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = ok and settings or {},
  })
  vim.lsp.enable(server)
end

-- for _, server in ipairs(servers.list) do
--   local ok, settings = pcall(require, "lsp.settings." .. server)

--   lspconfig[server].setup({
--     on_attach = on_attach,
--     capabilities = capabilities,
--     settings = ok and settings or {},
--   })
-- end

-- Diagnostics UI
vim.diagnostic.config({
  virtual_text = { prefix = "■", spacing = 2 },
  underline = false,
  signs = true,
  update_in_insert = false,
})

