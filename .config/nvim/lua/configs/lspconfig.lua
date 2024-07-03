-- EXAMPLE 
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = {
    "terraformls", "lua_ls", "gopls", "solargraph", "bashls", "pyright",
    "cssls", "html", "tsserver", "eslint", "tflint",
}


-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

-- terraform
lspconfig.terraformls.setup {
    on_attach = function(client, bufnr)
        -- Custom keybindings for LSP actions
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    end,
    settings = {
        terraform = {
            lint = {
                enable = true,
            }
        },
    },
    flags = {
        debound_text_changes = 150,
    }
}
