function show_global_diff()
    vim.api.nvim_command("Neotree float git_status")
end

function toggle_trouble()
    vim.api.nvim_command("TroubleToggle")
end

function copilot_status()
    local enabled = vim.g.copilot_enabled == 1
    local ret = ""
    if enabled then
        ret = "ﯙ "
    end
    return ret
end

require('lualine').setup {
    options = {
        theme = 'auto',
        component_separators = '',
        section_separators = { left = '', right = '' },
        globalstatus = true,
        refresh = { statusline = 500, },
    },

    sections = {
        lualine_a = {
            { 'mode', separator = { left = '', right = '' } }
        },

        lualine_b = { 'branch', { 'diff', symbols = { added = ' ', modified = ' ', removed = ' ' },
            on_click = show_global_diff } },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { { "copilot_status()" }, { 'filetype', icon_only = false, icon = true },
            { 'diagnostics',     always_visible = true, on_click = toggle_trouble } },
        lualine_z = { 'location', { 'progress', separator = { left = '', right = '' } } }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
}
