-- Bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",     -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
local plugins = {
  -- Optimize
  { 'dstein64/vim-startuptime',                 cmd = 'StartupTime' },

  -- GUI Enhancements
  -- Web Icons
  {
    'kyazdani42/nvim-web-devicons',
    config = function() require('plugin/nvim-web-devicons') end,
  },
  -- Colorschemes
  -- Gruvbox Theme w/ Plugin Support
  {
    "ellisonleao/gruvbox.nvim",
    --priority = 1000,
    --config = function() require('colors/gruvbox') end,
  },
  -- Dracula Theme w/ Plugin Support
  {
    'Mofiqul/dracula.nvim',
    priority = 1000,
    -- NOTE: Uncomment when you want to use
    -- config = function() require('colors/dracula') end,
    lazy = true,
  },
  -- Tokyonight Theme w/ Plugin Support
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    -- NOTE: Uncomment when you want to use
    -- config = function() require('colors/tokyonight.lua') end,
    lazy = true,
  },
  -- Catppuccin Theme w/ Plugin Support
  {
    'catppuccin/nvim',
    priority = 1000,
    name = 'catppuccin',
    -- NOTE: Uncomment when you want to use
    config = function() require('colors/catppuccin') end,
  },
  -- Doom One Theme w/ Plugin Support
  {
    'NTBBloodbath/doom-one.nvim',
    priority = 1000,
    -- NOTE: Uncomment when you want to use
    -- config = function() require('colors/DOOM') end,
    lazy = true,
  },
  -- Bufferline
  {
    'akinsho/bufferline.nvim',
    version = '*',
    config = function() require('plugin/nvim-bufferline') end,
    dependencies = 'kyazdani42/nvim-web-devicons',
  },
  -- Indent Blanklines
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function() require('plugin/indent-blankline') end,
  },
  -- Status Line
  {
    'nvim-lualine/lualine.nvim',
    config = function() require('plugin/lualine') end,
    dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true },
  },

  -- Navigation
  -- TODO: Look into leap.nvim
  -- tmux and vim splits navigation
  {
    'numToStr/Navigator.nvim',
    config = function() require('plugin/navigator') end,
  },

  -- Utility
  -- TODO: Look into editorconfig plugin
  -- Git
  'tpope/vim-fugitive',
  -- File Explorer
  {
    'stevearc/oil.nvim',
    opts = {
      skip_confirm_for_simple_edits = true,
      keymaps = {
        ['q'] = 'actions.close',
        ['<C-x>'] = 'actions.select_split',
        ['<C-h>'] = false,
      },
    },
    dependencies = 'kyazdani42/nvim-web-devicons',
  },
  -- Hydra: Submaps for Keymaps
  'nvimtools/hydra.nvim',
  -- Rooter: magically cd into project directory
  {
    'ahmedkhalf/project.nvim',
    config = function() require('plugin/project') end,
  },
  -- Fuzzy Finder
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    config = function() require('plugin/telescope') end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-lua/popup.nvim',
      'debugloop/telescope-undo.nvim',       -- Undo Tree
    },
    cmd = 'Telescope',
  },
  -- Telescope Extensions
  -- fzf
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  -- cder - change directory within telescope
  'zane-/cder.nvim',

  -- Git
  {
    'lewis6991/gitsigns.nvim',
    config = function() require('gitsigns').setup() end,
    dependencies = 'nvim-lua/plenary.nvim',
  },

  -- Intellisense
  -- LSP
  'neovim/nvim-lspconfig',
  -- Completion Engine
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Autocompletion
      'saadparwaiz1/cmp_luasnip',
      'lukas-reineke/cmp-rg',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lua',

      -- Snippets
      'L3MON4D3/LuaSnip',
      'windwp/nvim-autopairs',
      'rafamadriz/friendly-snippets',
    },
    config = function() require('plugin/nvim-cmp') end,
  },
  -- GitHub Copilot
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup({
        panel = { enabled = false },
        suggestion = { auto_trigger = false },
      })
    end,
  },
  -- Syntax Parser
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-refactor',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/nvim-treesitter-context',
    },
    -- Reference: https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation
    build = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    config = function() require('plugin/treesitter') end,
  },
  -- Flutter
  {
    'akinsho/flutter-tools.nvim',
    config = function() require('plugin/flutter-tools') end,
    dependencies = 'nvim-lua/plenary.nvim',
    ft = "dart",
  },
}

require("lazy").setup(plugins)
