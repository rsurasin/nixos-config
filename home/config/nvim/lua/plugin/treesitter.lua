-- Repo: https://github.com/nvim-treesitter/nvim-treesitter
-- Reference: https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/lua/plugin/treesitter.lua
-- Reference: https://github.com/nvim-lua/kickstart.nvim
-- NOTE: Open all folds in options.lua
-- Highly Experimental (if fold breaks, `zx` should fix it)
-- NOTE: Workaround to prevent "no folds found" and prevent highlighting
-- Reference: https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation
-- vim.opt.foldmethod     = 'expr'
-- vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
---WORKAROUND
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter' }, {
  group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
  callback = function()
    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr   = 'nvim_treesitter#foldexpr()'
  end
})
---ENDWORKAROUND

require 'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  -- Useful parsers (not needed now): graphql, kotlin, latex, query, regex, scss
  ensure_installed = {
    "c", "cpp", "css", "dart", "dockerfile",
    "fish", "go", "html", "javascript", "json",
    "lua", "python", "nix", "rust", "tsx",
    "typescript", "yaml", "vim", "vimdoc", "zig",
  },
  highlight = {
    enable = true,
    -- custom_captures = {
    -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
    -- ["foo.bar"] = "Identifier",
    -- },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<c-space>",
      node_incremental = "<c-space>",
      scope_incremental = "<c-s>",
      node_decremental = "<M-space>",       -- Mod/Meta is Alt
    },
  },
  -- BUG - Python indents issue: https://github.com/nvim-treesitter/nvim-treesitter/issues/1136
  -- Experimental feature
  indent = {
    enable = true,
    disable = { "python" },     -- BUG: https://github.com/nvim-treesitter/nvim-treesitter/issues/1136
  },
}
