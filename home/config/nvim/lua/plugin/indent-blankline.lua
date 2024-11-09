-- indent blank line v3 config
-- Help Docs: https://github.com/lukas-reineke/indent-blankline.nvim/blob/master/doc/indent_blankline.txt
-- `:help ibl.config`

vim.opt.list = true
vim.opt.listchars:append("space:⋅")

require("ibl").setup {
    indent = {
        char = "|",
    },
    scope = {
        show_start = false,
    },
}

