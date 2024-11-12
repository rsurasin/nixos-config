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

-- For TS/JS, check if Eslint LSP is attached, run `:EslintFixAll`
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.ts", "*.js", "*.tsx", "*.jsx" },
  callback = function()
    if vim.fn.exists(":EslintFixAll") > 0 then
      vim.cmd("EslintFixAll")
    end
  end,
})

-- For Python, check if `black` formatter is available and run it
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.py",
  callback = function()
    if vim.fn.executable("black") == 1 then
      vim.fn.jobstart({ "black", vim.api.nvim_buf_get_name(0) })
    end
  end,
})

-- For Go, check if `go fmt` is available and run it
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.go",
  callback = function()
    if vim.fn.executable("go") == 1 then
      vim.fn.jobstart({ "go", "fmt", vim.api.nvim_buf_get_name(0) })
    end
  end,
})
