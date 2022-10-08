M = {}

M.setup = function()

    require("lsp_lines").setup()
    require("trouble").setup({
        use_diagnostic_signs = true
    })

end

return M
