local opt = vim.opt_local

opt.tabstop = 2 -- Width of tab
opt.softtabstop = 2
opt.shiftwidth = 2

-- If Eslint LSP is attached, run `:EslintFixAll`
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.ts", "*.tsx" },
  callback = function()
    local clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })
    local has_eslint = false

    -- Check if eslint lsp is attached to buffer
    for _, client in ipairs(clients) do
      if client.name == "eslint" then
        has_eslint = true
        break
      end
    end

    if has_eslint then
      vim.cmd("EslintFixAll")
    end
  end,
})
