-- https://github.com/akinsho/nvim-bufferline.lua
require("bufferline").setup {
    options = {
        diagnostics = "nvim_lsp"
    }
}

-- Keymap
vim.keymap.set("n", "gb", ":BufferLinePick<CR>", { silent = true }) -- Choose Buffer
vim.keymap.set("n", "<leader>n", ":BufferLineCycleNext<CR>", { silent = true }) -- Next Buffer
vim.keymap.set("n", "<leader>p", ":BufferLineCyclePrev<CR>", { silent = true }) -- Prev Buffer
vim.keymap.set("n", "<leader>bn", ":BufferLineMoveNext<CR>", { silent = true }) -- Move Next Buffer
vim.keymap.set("n", "<leader>bp", ":BufferLineMovePrev<CR>", { silent = true }) -- Move Prev Buffer
