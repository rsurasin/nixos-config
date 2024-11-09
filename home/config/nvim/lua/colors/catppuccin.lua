-- set colorscheme after options
local frappe = require('catppuccin.palettes').get_palette 'frappe'
-- local latte = require('catppuccin.palettes').get_palette 'latte'
local mocha = require('catppuccin.palettes').get_palette 'mocha'
local macchiato = require('catppuccin.palettes').get_palette 'macchiato'

require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false,
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = { CursorLineNr = { fg = mocha.flamingo }, LineNr = { fg = frappe.surface2 }, },
    integrations = {
        cmp = true,
        gitsigns = true,
        telescope = true,
        indent_blankline = {
            enabled = true,
        },
        native_lsp = {
            enabled = true,
        },
        treesitter = true,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"
