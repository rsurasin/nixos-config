local opt = vim.opt_local

opt.tabstop = 4 -- Width of tab
opt.softtabstop = 4
opt.shiftwidth = 4

-- Check if `black` formatter is available and run it
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.py",
  callback = function()
    if vim.fn.executable("black") == 1 then
      vim.fn.jobstart({ "black", vim.api.nvim_buf_get_name(0) })
    end
  end,
})
