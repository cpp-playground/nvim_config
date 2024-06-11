M = {}


M.setup = function(config)
    require("nvim-web-devicons").setup({
        color_icons = true,
        default = true
    })

    local modules = {
        "editor_ui",
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

    saga.setup({
        finder = {
            keys =
            {
                toggle_or_open = '<CR>',
                quit = { "q", '<ESC>' },
                close = '<ESC>',

            }
        },
        definition = {
            edit = "<CR>",
            vsplit = "<C-v>",
            split = "<C-s>",
            tabe = "<C-t>",
            quit = { "q", "<ESC>" }
        },
        lightbulb = {
            enable = false
        },
        outline = {
            win_position = "right",
            win_with = "",
            win_width = 40,
            show_detail = true,
            auto_preview = false,
            auto_refresh = true,
            auto_close = true,
            custom_sort = nil,
            keys = {
                expand_or_jump = "<CR>",
                quit = "q",
            },
        },
        ui = {
            -- Currently, only the round theme exists
            theme = "round",
            -- This option only works in Neovim 0.9
            title = true,
            -- Border type can be single, double, rounded, solid, shadow.
            border = "rounded",
            winblend = 0,
            expand = "",
            collapse = "",
            preview = " ",
            code_action = "💡",
            diagnostic = "🐞",
            incoming = " ",
            outgoing = " ",
            hover = ' ',
            kind = {},
        },
    })


    require 'colorizer'.setup({ "*" }, {
        RGB    = true,  -- #RGB hex codes
        RRGGBB = true,  -- #RRGGBB hex codes
        names  = false, -- "Name" codes like Blue
    })

    require("todo-comments").setup({})

    require("Comment").setup({
        ignore = '^$',
        mapping = false,
    })




    local whichkey = require "which-key"
    local conf = {
        window = {
            border = "rounded",  -- none, single, double, shadow
            position = "bottom", -- bottom, top
        },
    }
    whichkey.setup(conf)

    require("ibl").setup()
    require("blame").setup()

    require("gitsigns").setup()
    require("lsp-inlayhints").setup {
        inlay_hints = {
            parameter_hints = {
                show = false
            },
        },
    }
end

return M
