local servers = {
    "rust_analyzer",
    "pyright",
    "tsserver",
    "sumneko_lua",
    "cssls",
    "html",
    "dockerls",
    "yamlls",
    "gopls",
    "jsonls",
    "rnix",
    "graphql",
}

-- override default LSP server options
-- lua language server (sumneko-lua)
local server_opts = {
    ["sumneko_lua"] = function()
        require'lsp.lua-ls'
    end,
    ["html"] = function()
        require'lsp.html-ls'
    end,
}

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local function has_key(table, key)
    return table[key] ~= nil
end

-- Use the server's custom settings, if they exist, otherwise default to the default options
for _, server in ipairs(servers) do
    if has_key(server_opts, server) then
        server_opts[server]()
    else
        require('lspconfig')[server].setup {
            on_attach = require("lsp/opts").on_attach,
            flags = lsp_flags,
        }
    end
end
