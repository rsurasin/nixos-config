-- Neovim
vim.keymap.set("n", "U", "<C-r>", { silent = true, desc = "Redo" })
-- Search and replace word under cursor
vim.keymap.set("n", "<leader>*", "*``cgn", { silent = true, desc = "Replace going forwards" })
vim.keymap.set("n", "<leader>#", "#``cgN", { silent = true, desc = "Replace going backwards" })
-- Buffers
vim.keymap.set("n", "<leader><Tab>", ":b#<CR>", { silent = true, desc = "Switch to last used buffer" })
vim.keymap.set("n", "<leader>d", ":bd<CR>", { silent = true, desc = "Delete buffer" })

-- Lazy Loaded Plugins Keymaps
-- telescope keymap
-- Undotree
vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>", { silent = true })

-- Fzf keymap
-- Search for files
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { silent = true, desc = "Find files" })
-- Open projects
vim.keymap.set("n", "<leader>fz", "<cmd>FzfLua zoxide<cr>", { silent = true, desc = "Change directory" })
-- Ripgrep Search
vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua live_grep<cr>", { silent = true, desc = "Live grep" })
vim.keymap.set("n", "<leader>fR", "<cmd>FzfLua grep<cr>", { silent = true, desc = "Grep" })
-- Search for/in Buffers
vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { silent = true, desc = "List buffers" })
vim.keymap.set("n", "<leader>fl", "<cmd>FzfLua lgrep_curbuf<cr>", { silent = true, desc = "Live grep current buffer" })
-- Search Help Tags, Manpages, Keymaps
vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua helptags<cr>", { silent = true, desc = "Search help tags" })
vim.keymap.set("n", "<leader>fm", "<cmd>FzfLua manpages<cr>", { silent = true, desc = "Search manpages" })
vim.keymap.set("n", "<leader>fk", "<cmd>FzfLua keymaps<cr>", { silent = true, desc = "Search keymaps" })
-- Git Integration
vim.keymap.set("n", "<leader>gc", "<cmd>FzfLua git_bcommits<cr>",
  { silent = true, desc = "Show git commits in current buffer" })
vim.keymap.set("n", "<leader>gC", "<cmd>FzfLua git_commits<cr>", { silent = true, desc = "Show git commits" })
-- LSP Integration
vim.keymap.set("n", "gr", "<cmd>FzfLua lsp_references<cr>", { silent = true, desc = "List LSP references under cursor" })
vim.keymap.set("n", "gI", "<cmd>FzfLua lsp_implementations<cr>",
  { silent = true, desc = "List LSP implementations under cursor" })
vim.keymap.set("n", "<leader>wd", "<cmd>FzfLua lsp_document_symbols<cr>",
  { silent = true, desc = "List all document symbols" })
