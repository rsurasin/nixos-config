-- Leader key -> <Space>
-- Set leader key early in config
vim.g.mapleader = " "

-- Disable Built-in Plugins
require('disable_builtin')

-- Lazy Plugins
require('plugins')

-- Helper Script
require('scripts')

-- LSP
require('lsp')
