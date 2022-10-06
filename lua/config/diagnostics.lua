function deactivate_inline_diag()
    vim.diagnostic.config({ virtual_text = true })
    vim.diagnostic.config({ virtual_lines = false })
end

function activate_inline_diag()
    vim.diagnostic.config({ virtual_text = false })
    vim.diagnostic.config({ virtual_lines = true })
end

require("lsp_lines").setup()
require("trouble").setup {
    use_diagnostic_signs = true
}
