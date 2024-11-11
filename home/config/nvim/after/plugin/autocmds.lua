-- If LSP is attached, run LSP formatting
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })
    if #clients > 0 then
      vim.lsp.buf.format({ async = true })
    end
  end,
})

-- Remove trainling whitespace on all files
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
      vim.cmd([[%s/\s\+$//e]])
    end,
})
