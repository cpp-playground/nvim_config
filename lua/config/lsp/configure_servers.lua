-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach_with_formatting = function(client, _)
    require("lsp-format").on_attach(client)
end

require('lspconfig')['bashls'].setup {
    on_attach = on_attach_with_formatting,
}

require('lspconfig')['clangd'].setup {
    on_attach = on_attach_with_formatting,
}

require('lspconfig')['cmake'].setup {
    on_attach = on_attach_with_formatting,
}

require('lspconfig')['sumneko_lua'].setup {
    on_attach = on_attach_with_formatting,
}

require('lspconfig')['jsonls'].setup {
    on_attach = on_attach_with_formatting,
}

require('lspconfig')['marksman'].setup {
    on_attach = on_attach_with_formatting,
}

require('lspconfig')['pyright'].setup {}

require('lspconfig')['rust_analyzer'].setup {
    on_attach = on_attach_with_formatting,
}

require('lspconfig')['yamlls'].setup {
    on_attach = on_attach_with_formatting,
    settings = {
        schemas = {
            ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
            ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
            ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
        }
    }
}


require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.black.with({ extra_args = { "-l 100" } }),
        require("null-ls").builtins.formatting.shfmt.with({ extra_args = { "--indent=4", "--language-dialect=bash" } }),
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
})
