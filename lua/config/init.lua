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

    saga.setup({
        finder = {
            edit = { "<CR>" },
            vsplit = "<C-v>",
            split = "<C-s>",
            tabe = "<C-t>",
            quit = { "q" },
        },
        definition = {
            edit = "<CR>",
            vsplit = "<C-v>",
            split = "<C-s>",
            tabe = "<C-t>",
            quit = "q",
        },
        lightbulb = {
            enable = false
        },
        -- ui = { border = "rounded" }
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
    require("lsp-inlayhints").setup {
        inlay_hints = {
            parameter_hints = {
                show = false
            },
        },
    }



    vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
    vim.api.nvim_create_autocmd("LspAttach", {
        group = "LspAttach_inlayhints",
        callback = function(args)
            if not (args.data and args.data.client_id) then
                return
            end

            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            require("lsp-inlayhints").on_attach(client, bufnr)
        end,
    })


end

return M
