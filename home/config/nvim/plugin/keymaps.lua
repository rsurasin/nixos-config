-- Key Mappings
local wk = require('which-key')
local gitsigns = require('gitsigns')
local opts = { silent = true }

-- Neovim
vim.keymap.set("n", "U", "<C-r>", opts)               -- Redo
-- Search and replace word under cursor
vim.keymap.set("n", "<leader>*", "*``cgn", opts)      -- Replace going forwards
vim.keymap.set("n", "<leader>#", "#``cgN", opts)      -- Replace going backwards
-- Buffers
vim.keymap.set("n", "<leader><Tab>", ":b#<CR>", opts) -- Switch to last used buffer
vim.keymap.set("n", "<leader>d", ":bd<CR>", opts)     -- Delete Buffer

-- Lazy Loaded Plugins Keymaps
-- telescope keymap
-- Search for files & open projects
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
vim.keymap.set("n", "<leader>fp", "<cmd>Telescope projects<cr>", opts)
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope cder<cr>", opts)
-- Ripgrep Search
vim.keymap.set("n", "<leader>rf", "<cmd>Telescope live_grep<cr>", opts)
vim.keymap.set("n", "<leader>rs", "<cmd>Telescope grep_string<cr>", opts)
-- Git Integration
vim.keymap.set("n", "<leader>gf", "<cmd>Telescope git_files<cr>", opts)
vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", opts)
vim.keymap.set("n", "<leader>gC", "<cmd>Telescope git_bcommits<cr>", opts)
-- Search for/in Buffers
vim.keymap.set("n", "<leader>ls", "<cmd>Telescope buffers<cr>", opts)
vim.keymap.set("n", "<leader>rb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", opts)
-- Search Help Tags
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)
-- LSP Integration
vim.keymap.set("n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", opts)
vim.keymap.set("n", "gI", "<cmd>Telescope lsp_implementations<cr>", opts)
vim.keymap.set("n", "<leader>wd", "<cmd>Telescope lsp_document_symbols<cr>", opts)
vim.keymap.set("n", "<leader>ww", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", { silent = true, buffer = true })
-- Undotree
vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>", opts)

-- Window operations
-- Helper functions for window actions
local function win_action_hydra(action)
  return function()
    vim.cmd(action)
    wk.show({ keys = "<C-W>", loop = true })
  end
end

-- Buffer operations
-- Helper functions for cycling buffers
local function buf_action_hydra(action)
  return function()
    vim.cmd(action)
    wk.show({ keys = "<leader>b", loop = true })
  end
end

-- Git operations
-- Helper functions for git actions
local git_mode_active = false

local function enter_git_mode()
  if git_mode_active then return end
  git_mode_active = true

  vim.cmd('mkview')
  vim.cmd('silent! %foldopen!')
  vim.bo.modifiable = true
  -- Disable 'space:⋅' and IndentBlankline
  vim.opt.list = false
  vim.cmd('IBLDisable')
  gitsigns.toggle_signs(true)
  gitsigns.toggle_linehl(true)
  gitsigns.toggle_deleted(true)
end

local function exit_git_mode()
  if not git_mode_active then return end
  git_mode_active = false

  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  -- Note: loadview commented out due to bug in original
  -- vim.cmd('loadview')
  vim.api.nvim_win_set_cursor(0, cursor_pos)
  vim.cmd('normal zv')
  gitsigns.toggle_signs(true)
  gitsigns.toggle_linehl(false)
  gitsigns.toggle_deleted(false)
  -- Enable 'space:⋅' and IndentBlankline
  vim.opt.list = true
  vim.cmd('IBLEnable')
end

local function git_action_hydra(action)
  return function()
    if type(action) == "function" then
      action()
    else
      vim.cmd(action)
    end
    wk.show({ keys = "<leader>g", loop = true })
  end
end

local function next_hunk()
  if vim.wo.diff then return ']c' end
  vim.schedule(function()
    gitsigns.next_hunk()
    vim.cmd 'normal zz'
  end)
  return '<Ignore>'
end

local function prev_hunk()
  if vim.wo.diff then return '[c' end
  vim.schedule(function()
    gitsigns.prev_hunk()
    vim.cmd 'normal zz'
  end)
  return '<Ignore>'
end

local function blame_show_full()
  gitsigns.blame_line { full = true }
end

-- Window Keymap
wk.add({
  { "<C-w>", group = "Window" },
  { "<C-w>+", win_action_hydra("resize +5"), desc = "⬆️ Taller" },
  { "<C-w>-", win_action_hydra("resize -5"), desc = "⬇️ Shorter" },
  { "<C-w><", win_action_hydra("vertical resize -5"), desc = "⬅️ Narrower" },
  { "<C-w>>", win_action_hydra("vertical resize +5"), desc = "➡️ Wider" },
  { "<C-w>=", desc = "Equal size" },
  { "<C-w>_", desc = "Max height" },
  { "<C-w>|", desc = "Max width" },
  { "<C-w>o", desc = "Only this window" },
  { "<C-w>q", desc = "Close window" },
  { "<C-w>r", desc = "Rotate windows" },
  { "<C-w><C-x>", desc = "Exchange windows" },
  { "<C-w>s", desc = "Horizontal split" },
  { "<C-w>x", "<C-w>s", desc = "Horizontal split" },
  { "<C-w>v", desc = "Vertical split" },
  { "<C-w>T", desc = "Move to new tab" },
})

-- Buffer Keymap
wk.add({
  { "<leader>b",      group = "Buffers" },
  { "<leader>bb",     function() vim.cmd("BufferLinePick") end,      desc = "Choose buffer" },
  { "<leader>bn",     buf_action_hydra("BufferLineCycleNext"),       desc = "Next buffer" },
  { "<leader>bp",     buf_action_hydra("BufferLineCyclePrev"),       desc = "Prev buffer" },
  { "<leader>bN",     buf_action_hydra("BufferLineMoveNext"),        desc = "Move buffer next" },
  { "<leader>bP",     buf_action_hydra("BufferLineMovePrev"),        desc = "Move buffer prev" },
  { "<leader>b<C-P>", function() vim.cmd("BufferLineTogglePin") end, desc = "Pin/Unpin buffer" },
})

-- Git Keymap
wk.add({
  { "<leader>g",        git_action_hydra(enter_git_mode),           group = "Git" },
  { "<leader>gj",       git_action_hydra(next_hunk),                desc = "Next hunk" },
  { "<leader>gk",       git_action_hydra(prev_hunk),                desc = "Prev hunk" },
  { '<leader>gD',       git_action_hydra(gitsigns.diffthis),        desc = 'Diff against index' },
  { '<leader>gu',       git_action_hydra(gitsigns.undo_stage_hunk), desc = 'Undo last stage' },
  { '<leader>gs',       git_action_hydra(gitsigns.stage_hunk),      desc = 'Stage hunk' },
  { '<leader>gS',       git_action_hydra(gitsigns.stage_buffer),    desc = 'Stage buffer' },
  { '<leader>gd',       git_action_hydra(gitsigns.toggle_deleted),  desc = 'Toggle deleted' },
  { '<leader>gr',       git_action_hydra(gitsigns.reset_hunk),      desc = 'Reset hunk' },
  { '<leader>gR',       git_action_hydra(gitsigns.reset_buffer),    desc = 'Reset buffer' },
  { '<leader>gb',       git_action_hydra(gitsigns.blame_line),      desc = 'Blame' },
  { '<leader>gB',       git_action_hydra(blame_show_full),          desc = 'Blame show full' },
  { '<leader>g/',       git_action_hydra(gitsigns.show),            desc = 'Show base file' }, -- show the base of the file
  { '<leader>g<Enter>', vim.cmd.Git,                                desc = 'Fugitive' },
  { '<Esc>',            exit_git_mode,                              desc = 'exit' },
})

