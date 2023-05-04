-- setup must be called before loading the colorscheme
-- Default options:
require("gruvbox").setup({
    overrides = {
        SignColumn = { link = "Normal" },
        LineNr = { fg = "LightGrey" },
        GruvboxGreenSign = { bg = "" },
        GruvboxOrangeSign = { bg = "" },
        GruvboxPurpleSign = { bg = "" },
        GruvboxYellowSign = { bg = "" },
        GruvboxRedSign = { bg = "" },
        GruvboxBlueSign = { bg = "" },
        GruvboxAquaSign = { bg = "" },
    }
})

vim.opt.background = "dark" -- or "light" for light mode
vim.cmd("colorscheme gruvbox")
