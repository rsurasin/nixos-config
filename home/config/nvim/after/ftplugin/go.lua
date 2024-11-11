local opt = vim.opt_local

opt.tabstop = 4 -- Width of tab
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = false -- Go doesn't do spaces

-- Check if `go fmt` is available and run it
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.go",
  callback = function()
    if vim.fn.executable("go") == 1 then
      vim.fn.jobstart({ "go", "fmt", vim.api.nvim_buf_get_name(0) })
    end
  end,
})
