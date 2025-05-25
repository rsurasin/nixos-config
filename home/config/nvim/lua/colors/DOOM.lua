require('doom-one').setup({
  cursor_coloring = true,
  terminal_colors = false,
  italic_comments = false,
  enable_treesitter = false,
  transparent_background = false,
  pumblend = {
    enable = true,
    transparency_amount = 80,
  },
  plugins_integrations = {
    neorg = false,
    barbar = false,
    bufferline = true,
    gitgutter = false,
    gitsigns = true,
    telescope = true,
    neogit = true,
    nvim_tree = false,
    dashboard = false,
    startify = false,
    whichkey = false,
    indent_blankline = true,
    vim_illuminate = false,
    lspsaga = false,
  },
})

-- BUG: Have to invoke another colorscheme first
vim.cmd("colorscheme onedark")
vim.cmd("colorscheme doom-one")
