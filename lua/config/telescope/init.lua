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
    telescope.load_extension('git_hunks')

end

return M

-- TODO: Let user add extensions easily?
-- TODO: Check how to setup nicer hunk based git status
-- Potentially based on gitsign quick fix?
--https://github.com/lewis6991/gitsigns.nvim/blob/233e65a521966831571f799846c481cecbe0117c/teal/gitsigns/actions.tl#L996
-- Or on its implementation 
--
