-- Configuration
require('Navigator').setup({
    auto_save = 'current',
    disable_on_zoom = true
})

-- Keymap
vim.keymap.set("n", "<C-h>", "<CMD>lua require('Navigator').left()<CR>", { silent = true })
vim.keymap.set("n", "<C-k>", "<CMD>lua require('Navigator').up()<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", "<CMD>lua require('Navigator').right()<CR>", { silent = true })
vim.keymap.set("n", "<C-j>", "<CMD>lua require('Navigator').down()<CR>", { silent = true })
