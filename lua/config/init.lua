M = {}


M.setup = function(config)
    require 'config.lualine'
    require 'config.bufferline'
    require 'config.diagnostics'
    require 'config.autocomplete'
    require 'config.alpha'
    require 'config.telescope'

    local language_support_cfg = require("config.language_support")
    language_support_cfg.setup(config.language_support)

    require("neo-tree").setup({
        close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "rounded",
        default_component_configs = {
            git_status = {

                symbols = {
                    -- Change type
                    added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                    modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
                    deleted   = "", -- this can only be used in the git_status source
                    renamed   = "", -- this can only be used in the git_status source
                    -- Status type
                    untracked = "",
                    ignored   = "",
                    unstaged  = "",
                    staged    = "",
                    conflict  = "",
                }
            },
        }
    })


    require("scrollbar").setup()

    local saga = require('lspsaga')

    saga.init_lsp_saga({
        border_style = "rounded",
        finder_action_keys = {
            open = "<CR>",
            vsplit = "<C-v>",
            split = "<C-s>",
            tabe = "<C-t>",
            quit = "q",
        },
        definition_action_keys = {
            open = "<CR>",
            vsplit = "<C-v>",
            split = "<C-s>",
            tabe = "<C-t>",
            quit = "q",
        },
        code_action_lightbulb = {
            enable = false
        },

    })


    require 'colorizer'.setup({ "*" }, {
        RGB    = true; -- #RGB hex codes
        RRGGBB = true; -- #RRGGBB hex codes
        names  = false; -- "Name" codes like Blue
    })

    require("todo-comments").setup({})

    require("Comment").setup({
        ignore = '^$',
        mapping = false,
    })




    local whichkey = require "which-key"
    local conf = {
        window = {
            border = "single", -- none, single, double, shadow
            position = "bottom", -- bottom, top
        },
    }
    whichkey.setup(conf)


    require("indent_blankline").setup {
        -- for example, context is off by default, use this to turn it on
        show_context_start = false,
        show_current_context = true,
    }


    require("gitsigns").setup()

    vim.o.sessionoptions = "buffers,curdir,localoptions,options,tabpages"
    require("auto-session").setup {
        auto_restore_enabled = false,
    }
    require("session-lens").setup()


end

return M
