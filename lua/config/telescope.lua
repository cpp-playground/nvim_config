local telescope = require('telescope')
telescope.setup({
    extensions = {
        glyph = {
            action = function(glyph)
                vim.api.nvim_put({ glyph.value }, 'c', false, true)
            end,
        },
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
        },
    },
})


telescope.load_extension('fzf')
telescope.load_extension('glyph')
telescope.load_extension('themes')
telescope.load_extension('session-lens')
