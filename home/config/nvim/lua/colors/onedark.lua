-- Config
vim.g.background = "dark"
-- Different Styles: default, darker, cool, deep, warm, warmer
vim.g.onedark_style = "warm"
-- vim.g.onedark_sidebars = { "qf", "vista_kind", "terminal", "packer" }

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
-- vim.g.onedark_colors = { hint = "orange", error = "ff0000" }

-- Load the colorscheme
vim.cmd[[colorscheme onedark]]

-- Enables True Color Support
vim.opt.termguicolors = true

