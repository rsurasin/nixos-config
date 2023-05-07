-- Key Mappings
local Hydra = require('hydra')
local gitsigns = require('gitsigns')
local no_timeout = { timeout = false }
local opts = { silent = true }

-- Neovim
vim.keymap.set("n", "U", "<C-r>", opts) -- Redo
-- Search and replace word under cursor
vim.keymap.set("n" ,"<leader>*", "*``cgn", opts) -- Replace going forwards
vim.keymap.set("n" ,"<leader>#", "#``cgN", opts) -- Replace going backwards
-- Buffers
vim.keymap.set("n", "<leader><Tab>", ":b#<CR>", opts) -- Switch to last used buffer
vim.keymap.set("n", "<leader>d", ":bd<CR>", opts) -- Delete Buffer

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

-- Hydra Submaps
-- Submap: Resize Windows
-- Bug: Can't have `_` in hint as head key leads to error
--local win_hint = [[
-- _<_: win narrow     _-_: win short     _=_: win equal
-- _>_: win wide       _+_: win tall      _v_: vsplit
-- _|_: full width     ___: full height   _x_: hsplit
-- _s_: switch win     ^ ^                _q_: close win
-- ^
-- ^ ^               _<Esc>_: Exit
--]]

Hydra({
    name = 'Resize Windows',
    --hint = win_hint,
    config = {
        color = 'pink',
        buffer = bufnr,
        invoke_on_body = true,
        --hint = {
        --    border = 'rounded'
        --},
    },
    mode = {'n','x'},
    body = '<C-W>',
    heads = {
        { '<', '<C-W>5<', { desc = 'Current window resize narrower' }, no_timeout },
        { '>', '<C-W>5>', { desc = 'Current window resize wider' }, no_timeout },
        { '|', '<C-W>|',  { desc = 'Window takes entire width' }, no_timeout },
        { '-', '<C-W>5-', { desc = 'Current window resize shorter' }, no_timeout },
        { '+', '<C-W>5+', { desc = 'Current window resize taller' }, no_timeout },
        { '_', '<C-W>_',  { desc = 'Window takes entire height' }, no_timeout  },
        { '=', '<C-W>=',  { desc = 'Windows same size' }, no_timeout },
        { 'v', '<C-W>v',  { desc = 'Vertical split' }, no_timeout },
        { 'x', '<C-W>s',  { desc = 'Horizontal split' }, no_timeout },
        { 's', '<C-W>x',  { desc = 'Switch current window w/ next' }, no_timeout },
        { 'q', '<C-W>q',  { desc = 'Close window' }, no_timeout },
        { '<Esc>', nil, { exit = true, nowait = true, desc = 'exit' } },
    },
})

-- Submap: Cycle Buffers
Hydra({
    name = 'Cycle Buffers',
    config = {
        color = 'pink',
        buffer = bufnr,
        invoke_on_body = true,
    },
    mode = {'n','x'},
    body = '<leader>b',
    heads = {
        { 'b', '<cmd>BufferLinePick<cr>', { desc = 'Choose buffer' }, no_timeout },
        { 'n', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next buffer' }, no_timeout },
        { 'p', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Prev buffer' }, no_timeout },
        { 'N', '<cmd>BufferLineMoveNext<cr>', { desc = 'Move buffer next' }, no_timeout },
        { 'P', '<cmd>BufferLineMovePrev<cr>', { desc = 'Move buffer prev' }, no_timeout },
        { '<C-P>', '<cmd>BufferLineTogglePin<cr>', { desc = 'Pin/Unpin buffer' }, no_timeout },
        { '<Esc>', nil, { exit = true, nowait = true, desc = 'exit' } },
    },
})

-- Submap: Git
local git_hint = [[
 _J_: next hunk     _u_: undo last stage   _d_: show deleted   _b_: blame line
 _K_: prev hunk     _s_: stage hunk        _r_: reset hunk     _B_: blame show full 
 _D_: diff index    _S_: stage buffer      _R_: reset buffer   _/_: show base file
 ^
 ^ ^              _<Enter>_: Fugitive              _<Esc>_: exit
]]

Hydra({
    name = 'Git',
    hint = git_hint,
    config = {
        buffer = bufnr,
        color = 'pink',
        invoke_on_body = true,
        hint = {
            border = 'rounded'
        },
        on_enter = function()
            vim.cmd 'mkview'
            vim.cmd 'silent! %foldopen!'
            vim.bo.modifiable = true
            -- Disable 'space:⋅' and IndentBlankline
            vim.opt.list = false
            vim.cmd 'IndentBlanklineDisable'
            gitsigns.toggle_signs(true)
            gitsigns.toggle_linehl(true)
            gitsigns.toggle_deleted(true)
        end,
        on_exit = function()
            local cursor_pos = vim.api.nvim_win_get_cursor(0)
            -- Bug: Causing error
            -- vim.cmd 'loadview'
            vim.api.nvim_win_set_cursor(0, cursor_pos)
            vim.cmd 'normal zv'
            gitsigns.toggle_signs(true)
            gitsigns.toggle_linehl(false)
            gitsigns.toggle_deleted(false)
            -- Enable 'space:⋅' and IndentBlankline
            vim.opt.list = true
            vim.cmd 'IndentBlanklineEnable'
        end,
    },
    mode = {'n','x'},
    body = '<leader>g',
    heads = {
        { 'J',
        function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gitsigns.next_hunk() vim.cmd 'normal zz' end)
            return '<Ignore>'
        end,
        { expr = true, desc = 'next hunk' } },
        { 'K',
        function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gitsigns.prev_hunk() vim.cmd 'normal zz' end)
            return '<Ignore>'
        end,
        { expr = true, desc = 'prev hunk' } },
        { 'D', gitsigns.diffthis, { exit = true, desc = 'Diff against index' } },
        { 'u', gitsigns.undo_stage_hunk, { desc = 'undo last stage' } },
        { 's', gitsigns.stage_hunk, { silent = true, desc = 'stage hunk' } },
        { 'S', gitsigns.stage_buffer, { desc = 'stage buffer' } },
        { 'd', gitsigns.toggle_deleted, { nowait = true, desc = 'toggle deleted' } },
        { 'r', gitsigns.reset_hunk, { silent = true, desc = 'reset hunk' } },
        { 'R', gitsigns.reset_buffer, { desc = 'reset buffer' } },
        { 'b', gitsigns.blame_line, { desc = 'blame' } },
        { 'B', function() gitsigns.blame_line{ full = true } end, { desc = 'blame show full' } },
        { '/', gitsigns.show, { exit = true, desc = 'show base file' } }, -- show the base of the file
        { '<Enter>', vim.cmd.Git, { exit = true, desc = 'Fugitive' } },
        { '<Esc>', nil, { exit = true, nowait = true, desc = 'exit' } },
    }
})
