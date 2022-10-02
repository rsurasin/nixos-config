-- Leader key -> <Space>
-- Set leader key early in config
vim.g.mapleader = " "

-- Packer Plugins
require('impatient')
require('plugins')

-- Helper Script
require('scripts')

-- LSP
require('lsp')
