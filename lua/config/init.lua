M = {}


M.setup = function(config)
    require("nvim-web-devicons").setup({
        color_icons = true,
        default = true
    })

    local modules = {
        "editor_ui",
        "alpha",
        "language_support",
        "neo-tree",
        "diagnostics",
        "telescope",
        "autocomplete"
    }
    for _, mod in ipairs(modules) do
        require("config." .. mod).setup(config[mod])
    end

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
            border = "rounded", -- none, single, double, shadow
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
