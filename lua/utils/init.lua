M = {}


M.run_command = function(command)
    local handle = io.popen(command)
    if handle then
        local res = handle:read("*a")
        handle:close()
        return res
    end
    return nil
end


M.prequire = function(mod_name)
    local ok, err = pcall(require, mod_name)
    if not ok then return nil, err end
    return err
end

M.diagnostics_as_virtual_text = function()
    vim.diagnostic.config({ virtual_text = true })
    vim.diagnostic.config({ virtual_lines = false })
end

M.diagnostics_as_virtual_lines = function()
    vim.diagnostic.config({ virtual_text = false })
    vim.diagnostic.config({ virtual_lines = true })
end

M.toggle_diagnostic_virtual_lines = function()

    vim.diagnostic.config({ virtual_text = vim.diagnostic.config().virtual_lines })
    vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
end

M.sanitize_config = function(config)
    -- lsp config is required
    if config.language_support == nil then
        config.language_support = {}
    end

    if config.colorscheme == nil then
        config.colorscheme = "gruvbox"
    end

    return config
end


return M
