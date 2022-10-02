-- Key Mappings
local opts = { silent = true }

-- Neovim
vim.keymap.set("n", "U", "<C-r>", opts) -- Redo
-- Search and replace word under cursor
vim.keymap.set("n" ,"<leader>*", "*``cgn", opts) -- Replace going forwards
vim.keymap.set("n" ,"<leader>#", "#``cgN", opts) -- Replace going backwards
-- Buffers
vim.keymap.set("n", "<leader><Tab>", ":b#<CR>", opts) -- Switch to last used buffer
vim.keymap.set("n", "<leader>=", "<C-W>=", opts) -- Buffer windows same size
vim.keymap.set("n", "<leader>_", "<C-W>_", opts) -- Buffer window take entire height
vim.keymap.set("n", "<leader>|", "<C-W>|", opts) -- Buffer window take entire width
-- Prepend w/ a number to repeat command
vim.keymap.set("n", "<leader>,", "<C-W>5<", opts) -- Current buffer window resize narrower
vim.keymap.set("n", "<leader>.", "<C-W>5>", opts) -- Current buffer window resize wider
-- Prepend w/ a number to repeat command
vim.keymap.set("n", "<leader>-", "<C-W>5-", opts) -- Current buffer window resize shorter
vim.keymap.set("n", "<leader>+", "<C-W>5+", opts) -- Current buffer window resize taller
vim.keymap.set("n", "<leader>d", ":bd<CR>", opts) -- Delete Buffer

-- Lazy Loaded Plugins Keymaps
-- nvim-tree keymap
-- Open/close nvim-tree
vim.keymap.set("n", "<leader>o", "<cmd>NvimTreeToggle<cr>", opts)

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
vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_bcommits<cr>", opts)
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
