M = {}
M.setup = function()

    local telescope = require('telescope')
    telescope.setup({
        extensions = {
            glyph = {
                action = function(glyph)
                    vim.api.nvim_put({ glyph.value }, 'c', false, true)
                end,
            },
        },
    })


    telescope.load_extension('glyph')
    telescope.load_extension('themes')

end

return M
