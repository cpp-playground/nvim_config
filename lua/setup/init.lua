-- Bootstrap packer install
require "setup.packer_bootstrap"
local is_bootstraping = ensure_packer()

local user_plugins = require("utils").prequire("setup.user")

-- Installing main packages
return require("packer").startup(function(use)
    -- Installers
    use "wbthomason/packer.nvim"            -- Install plugins

    use "williamboman/mason.nvim"           -- Install tools
    use "williamboman/mason-lspconfig.nvim" -- Use Mason to install lsp clients
    use "jayp0521/mason-null-ls.nvim"       -- Use Mason to install formatters
    use "jay-babu/mason-nvim-dap.nvim"      -- Use Mason to install DAP tools

    -- Libs
    use "nvim-lua/plenary.nvim"        -- Async programming library
    use "MunifTanjim/nui.nvim"         -- UI Library
    use "stevearc/dressing.nvim"       -- Better looking windows
    use "kyazdani42/nvim-web-devicons" -- Set of icons with color support

    -- LSP
    use "neovim/nvim-lspconfig"         -- LSP Server configurator
    use "lukas-reineke/lsp-format.nvim" -- LSP Based code formating
    use { "glepnir/lspsaga.nvim",
        requires = {
            { "nvim-tree/nvim-web-devicons" },
            { "nvim-treesitter/nvim-treesitter" }
        }
    } -- LSP Integration (code action, etc)

    use 'eandrju/cellular-automaton.nvim'
    --DAP
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
    use "theHamsta/nvim-dap-virtual-text" -- Show debug info inline

    -- Formaters
    use "jose-elias-alvarez/null-ls.nvim" -- Run formaters as if they were LSP clients

    -- Language support
    use "nvim-treesitter/nvim-treesitter" -- Code parser

    -- Auto-completion
    use {
        "hrsh7th/nvim-cmp",         -- Auto-completion engine
        requires = {
            "hrsh7th/cmp-buffer",   -- Current buffer source for cmp
            "hrsh7th/cmp-nvim-lsp", -- LSP source for LSP
        }
    }
    use "onsails/lspkind.nvim"                -- cmp output formating
    use({ "L3MON4D3/LuaSnip", tag = "v1.*" }) -- Snipet expansion for cmp

    use "lvimuser/lsp-inlayhints.nvim"

    -- UI ELements
    use {
        "akinsho/bufferline.nvim",
    }                                         -- Buffer line (aka tabs)
    use "nvim-lualine/lualine.nvim"           -- Status line (bottom one)
    use "petertriho/nvim-scrollbar"           -- Side scrollbar
    use "lukas-reineke/indent-blankline.nvim" -- Show indent lines
    use "rcarriga/nvim-notify"                -- Pop-up utiliity
    use "lewis6991/gitsigns.nvim"             -- Nice git status

    -- File explorer
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
    use { "nvim-neo-tree/neo-tree.nvim", branch = "v2.x", }

    use "folke/trouble.nvim"   -- Diagnostic visualizer
    use "folke/which-key.nvim" -- Shows which commands are available


    -- Misc
    use "norcalli/nvim-colorizer.lua"                  -- Shows colors such as #452
    use "folke/todo-comments.nvim"                     -- Support TODO style comments (TODO HACK, FIX, NOTE, BUG WARN)
    use "p00f/nvim-ts-rainbow"                         -- Pair apply colors to matching pair of delimiters
    use "https://git.sr.ht/~whynothugo/lsp_lines.nvim" -- Display LSP diagnostic inline
    use "famiu/bufdelete.nvim"                         -- Nicer buffer closing
    use "numToStr/Comment.nvim"                        -- Comment/Uncomment code


    -- Telescope and extensions
    use { "nvim-telescope/telescope.nvim", tag = "0.1.x" }           --Finds stuff
    use "ghassan0/telescope-glyph.nvim"                              -- Find glyphs like 
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" } -- Fzf finder to go faster

    -- Dashboard
    use "goolord/alpha-nvim"


    -- Themes
    use "themercorp/themer.lua"


    -- Copilot?
    use "github/copilot.vim"
    use "Exafunction/codeium.vim"

    use "APZelos/blamer.nvim"

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if is_bootstraping then
        require("packer").sync()
    end
end)
