-- Bootstrap
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  -- Plugins
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- Optimize
  -- TODO: this plugin will be redundant once https://github.com/neovim/neovim/pull/15436 is merged
  use 'lewis6991/impatient.nvim'
  use { 'dstein64/vim-startuptime', cmd = 'StartupTime' }

  -- GUI Enhancements
  -- Web Icons
  use {
    'kyazdani42/nvim-web-devicons',
    config = [[require('plugin/nvim-web-devicons')]],
  }
  -- Colorschemes
  -- Gruvbox Theme w/ Plugin Support
  use {
    "ellisonleao/gruvbox.nvim",
    config = [[require('colors/gruvbox')]],
  }
  -- Dracula Theme w/ Plugin Support
  use {
    'Mofiqul/dracula.nvim',
    -- config = [[require('colors/dracula')]],
  }
  -- Tokyonight Theme w/ Plugin Support
  use {
    'folke/tokyonight.nvim',
    -- NOTE: Uncomment when you want to use
    -- config = [[require('colors/tokyonight.lua')]]
  }
  -- Onedark Theme w/ Plugin Support
  use {
    'navarasu/onedark.nvim',
    -- NOTE: Uncomment when you want to use
    -- config = [[require('colors/onedark')]]
  }
  -- Rose-Pine Theme w/ Pluggin Support
  use {
    'rose-pine/neovim',
    as = 'rose-pine',
    tag = 'v1.*',
    -- NOTE: Uncomment when you want to use
    -- config = [[require('colors/rose-pine')]]
  }
  -- Catppuccin Theme w/ Plugin Support
  use {
    'catppuccin/nvim',
    as = 'catppuccin',
    -- config = [[require('colors/catppuccin')]],
  }
  -- Kanagawa Theme w/ Plugin Support
  use {
    'rebelot/kanagawa.nvim',
    -- config = [[require('colors/kanagawa')]],
  }
  -- Doom One Theme w/ Plugin Support
  use({
    'NTBBloodbath/doom-one.nvim',
    -- config = [[require('colors/DOOM')]],
  })
  -- Bufferline
  use {
    'akinsho/bufferline.nvim',
    tag = 'v2.*',
    config = [[require('plugin/nvim-bufferline')]],
    requires = 'kyazdani42/nvim-web-devicons'
  }
  -- Indent Blanklines
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = [[require('plugin/indent-blankline')]],
  }
  -- Status Line
  use {
    'nvim-lualine/lualine.nvim',
    config = [[require('plugin/lualine')]],
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  -- Navigation
  -- TODO: Look into lightspeed.nvim
  -- tmux and vim splits navigation
  use {
    'numToStr/Navigator.nvim',
    config = [[require('plugin/navigator')]]
  }

  -- Utility
  -- TODO: Look into editorconfig plugin
  -- File Explorer
  use {
    'kyazdani42/nvim-tree.lua',
    config = [[require('plugin/nvim-tree')]],
    requires = 'kyazdani42/nvim-web-devicons',
    cmd = 'NvimTreeToggle',
  }
  -- Fuzzy Finder
  use {
    'nvim-telescope/telescope.nvim',
    config = [[require('plugin/telescope')]],
    requires = { {'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' } },
    cmd = 'Telescope',
    module = 'telescope',
  }
  -- Telescope Extensions
  -- fzf
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
  -- cder - change directory within telescope
  use {'zane-/cder.nvim'}
  -- Telescope-file-browser
  -- TODO: When this plugin incorporates depth, come back
  -- use { "nvim-telescope/telescope-file-browser.nvim" }
  -- Git
  use {
    'lewis6991/gitsigns.nvim',
    config = [[require('plugin/gitsigns')]],
    requires = {
      'nvim-lua/plenary.nvim'
    },
    tag = 'release' -- To use the latest release
  }
  -- HACK: Need to lazy load to prevent plenary async error (SIGABRT) https://github.com/TimUntersberger/neogit/issues/206#
  use {
    'TimUntersberger/neogit',
    cmd = 'Neogit',
    config = [[require('plugin/neogit')]],
    requires = 'nvim-lua/plenary.nvim'
  }
  -- Rooter: magically cd into project directory
  use {
    'ahmedkhalf/project.nvim',
    config = [[require('plugin/project')]]
  }
  -- Intellisense
  use {
    'neovim/nvim-lspconfig',
  }
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'L3MON4D3/LuaSnip',
      'windwp/nvim-autopairs',
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
      { 'lukas-reineke/cmp-rg', after = 'nvim-cmp' },
      'hrsh7th/cmp-nvim-lsp',
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
    },
    config = [[require('plugin/nvim-cmp')]]
  }
  -- use {
  --   'williamboman/nvim-lsp-installer',
  --   config = [[require('lsp/nvim-lsp-installer')]]
  -- }
  -- Syntax Parser
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
        'nvim-treesitter/nvim-treesitter-refactor',
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    -- Reference: https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation
    run = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
    end,
    config = [[require('plugin/treesitter')]]
  }
  -- Flutter
  use {
    'akinsho/flutter-tools.nvim',
    config = [[require('plugin/flutter-tools')]],
    requires = 'nvim-lua/plenary.nvim',
    ft = "dart",
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

