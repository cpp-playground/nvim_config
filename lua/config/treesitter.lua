require 'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "c",
        "cpp",
        "rust",
        "python",
        "bash",
        "cmake",
        "json",
        "lua",
        "markdown",
        "yaml"
    },

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    rainbow = {
        enable = true,
        extended_mode = false,
        max_file_lines = nil,
    },
    autopairs = { enable = true },
    autotag = { enable = true },
    incremental_selection = { enable = true },
    indent = { enable = false }
}
