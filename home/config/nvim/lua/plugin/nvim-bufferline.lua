-- https://github.com/akinsho/nvim-bufferline.lua
require("bufferline").setup {
    options = {
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "left"
            }
        },
        diagnostics = "nvim_lsp"
    }
}

-- Keymap
vim.keymap.set("n", "gb", ":BufferLinePick<CR>", { silent = true }) -- Choose Buffer
vim.keymap.set("n", "<leader>n", ":BufferLineCycleNext<CR>", { silent = true }) -- Next Buffer
vim.keymap.set("n", "<leader>p", ":BufferLineCyclePrev<CR>", { silent = true }) -- Prev Buffer
vim.keymap.set("n", "<M-n>", ":BufferLineMoveNext<CR>", { silent = true }) -- Next Buffer
vim.keymap.set("n", "<M-p>", ":BufferLineMovePrev<CR>", { silent = true }) -- Prev Buffer
vim.keymap.set("n", "<leader>bp", ":BufferLineTogglePin<CR>", { silent = true }) -- Prev Buffer
