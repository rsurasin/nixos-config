M = {
  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  on_attach = function(client, bufnr)
    -- require('lspconfig')
    local function set_keymap(...) vim.keymap.set(...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    --Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap = true, silent = true }
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    set_keymap('n', 'gD', vim.lsp.buf.declaration, bufopts)
    set_keymap('n', 'gd', vim.lsp.buf.definition, bufopts)
    set_keymap('n', 'K', vim.lsp.buf.hover, bufopts)
    set_keymap('i', '<C-h>', vim.lsp.buf.signature_help, bufopts)
    set_keymap('n', 'gT', vim.lsp.buf.type_definition, bufopts)
    set_keymap('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    set_keymap('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)

    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    set_keymap('n', '<leader>e', vim.diagnostic.open_float, opts)
    set_keymap('n', '<leader>[', vim.diagnostic.goto_prev, opts)
    set_keymap('n', '<leader>]', vim.diagnostic.goto_next, opts)
    set_keymap('n', '<leader>q', vim.diagnostic.setloclist, opts)
    set_keymap("n", "<space>f=", function()
      vim.lsp.buf.format { async = true }
    end, bufopts)

    -- Unused
    -- set_keymap('n', 'gr', telescope.builtin.lsp_references(), opts) -- Implemented w/ Telescope in keymaps.lua
    -- set_keymap('n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts) -- Implemented w/ Telescope in keymaps.lua
    -- set_keymap('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    -- set_keymap('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    -- set_keymap('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
  end,
}

return M
