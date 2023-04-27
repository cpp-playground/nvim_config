M = {}


M.setup = function(config)
    local treesitter_languages = {}
    if config.supported_languages ~= nil then
        treesitter_languages = config.supported_languages
    end
    require 'nvim-treesitter.configs'.setup({
        ensure_installed = treesitter_languages,
        auto_install = true,
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
    })


    require("mason").setup({
        ui = {
            check_outdated_packages_on_open = true,
            border = "rounded",
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            },
            keymaps = {
                -- Keymap to expand a package
                toggle_package_expand = "<CR>",
                -- Keymap to install the package under the current cursor position
                install_package = "i",
                -- Keymap to reinstall/update the package under the current cursor position
                update_package = "u",
                -- Keymap to check for new version for the package under the current cursor position
                check_package_version = "c",
                -- Keymap to update all installed packages
                update_all_packages = "U",
                -- Keymap to check which installed packages are outdated
                check_outdated_packages = "C",
                -- Keymap to uninstall a package
                uninstall_package = "d",
                -- Keymap to cancel a package installation
                cancel_installation = "<C-c>",
                -- Keymap to apply language filter
                apply_language_filter = "<C-f>",
            },
        },
    })
    require("mason-nvim-dap").setup({
        ensure_installed = { "codelldb" },
        handlers = {},
        automatic_setup = true,
    })

    local lsp_servers = {}
    if config.lsp ~= nil and config.lsp.ensure_installed ~= nil then
        lsp_servers = config.lsp.ensure_installed
    end
    require("mason-lspconfig").setup({
        ensure_installed = lsp_servers,
        automatic_installation = true,
    })


    local null_ls_servers = {}
    if config.null_ls ~= nil and config.null_ls.ensure_installed ~= nil then
        null_ls_servers = config.null_ls.ensure_installed
    end
    require("mason-null-ls").setup({
        ensure_installed = null_ls_servers,
        automatic_installation = false,
    })


    local lsp_servers_configs = {}
    if config.lsp ~= nil and config.lsp.server_configs ~= nil then
        lsp_servers_configs = config.lsp.server_configs
    end
    for server, conf in pairs(lsp_servers_configs) do
        require("lspconfig")[server].setup(conf)
    end


    local null_ls_servers_configs = {}
    if config.null_ls ~= nil and config.null_ls.sources ~= nil then
        null_ls_servers_configs = config.null_ls.sources
    end
    require("null-ls").setup({
        sources = null_ls_servers_configs,
        on_attach = function(client, bufnr)
            if client.supports_method("textDocument/formatting") then
                vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = augroup,
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format({ bufnr = bufnr })
                    end,
                })
            end
        end,
    })
end


M.on_attach_with_format = function(client, _)
    require("lsp-format").on_attach(client)
end

M.on_attach_default = function(_, _)
end

return M
