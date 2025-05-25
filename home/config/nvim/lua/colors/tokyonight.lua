-- Color Scheme (Set before Intellisense)
-- https://cyfyifanchen.com/neovim-true-color/
-- vim.o.background == "dark"   -- Set dark variant of Tokyonight
vim.g.tokyonight_style = "storm"
-- vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
-- vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }

-- Load the Colorscheme
vim.cmd [[colorscheme tokyonight]]

-- Enables True Color Support
vim.opt.termguicolors = true
