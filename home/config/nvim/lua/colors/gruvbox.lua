-- setup must be called before loading the colorscheme

require("gruvbox").setup({
  overrides = {
    LineNr = { fg = "LightGrey" },
    -- Transparent sign colors
    SignColumn = { link = "Normal" },
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
