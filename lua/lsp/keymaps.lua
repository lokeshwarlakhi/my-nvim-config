return function(_, bufnr) -- Exports an anonymous function.
  local map = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  map("gd", vim.lsp.buf.definition, "Go to definition")
  map("K", vim.lsp.buf.hover, "Hover docs")
  map("<leader>rn", vim.lsp.buf.rename, "Rename")
  map("<leader>ca", vim.lsp.buf.code_action, "Code action")
end