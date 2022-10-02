--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

return require'lspconfig'.html.setup {
  capabilities = capabilities,
  on_attach = require'lsp/opts'.on_attach,
  flags = lsp_flags,
}

