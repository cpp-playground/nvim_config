local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local previewers = require "telescope.previewers"
local conf = require("telescope.config").values

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local git = require("git_support")


local function make_entry(entry)
    return {
        value = entry,
        display = entry["file"] .. "/" .. entry["index"],
        ordinal = entry["data"].raw,
        path = entry["file"],
    }
end

local diff_previewer = previewers.new_buffer_previewer {
    title = "Current Hunk diff",

    get_buffer_by_name = function(_, entry)
        return entry.value
    end,

    define_preview = function(self, entry, _)
        local t = {}
        for str in entry.value["data"].print:gmatch("([^\n]*)\n?") do
            table.insert(t, str)
        end
        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, t)
        vim.api.nvim_buf_set_option(self.state.bufnr, "syntax", "diff")
    end,
}


M = {}

M.find_hunks = function(opts)
    opts = opts or {}

    pickers.new(opts,
        {
            prompt_title = "Hunks",
            selection_caret = "> 﨡",
            entry_prefix = "  﨡",
            multi_icon = "蘒",

            finder = finders.new_table {
                results = git.get_hunks(),
                entry_maker = make_entry
            },
            -- previewer = conf.grep_previewer(opts),
            previewer = diff_previewer,
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(prompt_bufnr, _)
                actions.select_default:replace(function()
                    local picker = action_state.get_current_picker(prompt_bufnr)

                    local diff = ""
                    for _, selection in ipairs(picker:get_multi_selection()) do
                        diff = diff .. selection.value["data"].raw .. "\n"
                    end
                    actions.close(prompt_bufnr)

                    local diff_file_name = os.tmpname()
                    local patch_file = io.open(diff_file_name, "w")
                    if patch_file then
                        patch_file:write(diff)
                        patch_file:close()
                        require("utils").run_command("git apply --cached " .. diff_file_name)
                    end
                end)
                return true
            end,
        }):find()
end

return M
