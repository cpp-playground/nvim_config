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
        ordinal = entry["data"],
        path = entry["file"],
    }
end

local find_hunks = function(opts)
    opts = opts or {}

    pickers.new(opts,
        {
            prompt_title = "Hunks",
            finder = finders.new_table {
                results = git.get_hunks(),
                entry_maker = make_entry
            },
            previewer = conf.grep_previewer(opts),
            sorter = conf.generic_sorter(opts),
            attach_mappings = function(prompt_bufnr, map)
                actions.select_default:replace(function()
                    local picker = action_state.get_current_picker(prompt_bufnr)

                    local diff = ""
                    for _, selection in ipairs(picker:get_multi_selection()) do
                        diff = diff .. selection.value["data"]
                    end
                    -- require("notify")(diff)
                    actions.close(prompt_bufnr)

                    local diff_file_name = os.tmpname()
                    require("notify")(diff_file_name)
                    local patch_file = io.open(diff_file_name, "w")
                    if patch_file then
                        patch_file:write(diff)
                        patch_file:close()
                        require("notify")(require("utils").run_command("git apply --cached " .. diff_file_name))
                    else
                        require("notify")("RAHHHHHHHH")
                    end
                end)
                return true
            end,
        }):find()


end


find_hunks()
