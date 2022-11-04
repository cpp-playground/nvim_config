M = {}

M.win_options = {
    winhighlight = "Normal:Normal,FloatBorder:Normal"
}


M.make_border = function(border_text)
    local border = {
        style = "rounded",
        text = border_text,
    }
    return border
end



local function get_content(component)
    local content = vim.api.nvim_buf_get_lines(component.bufnr, 0, vim.api.nvim_buf_line_count(0), false)
    return table.concat(content, "\n")
end

local function commit_and_close(layout, desc, msg)
    local description = get_content(desc)
    local message = get_content(msg)

    local full_message = description .. "\n" .. message

    local success = os.execute('git commit -m "' .. full_message .. '"')
    if success == 0 then
        require("notify")(description, "info", { title = "Git commit: " })
    else
        require("notify")("Error while trying to commit", "error", { title = "Git commit: " })
    end
    layout:unmount()
end

M.make_git_commit_layout = function()
    local Layout = require("nui.layout")
    local Popup = require("nui.popup")

    local commit_desc = Popup(
        {
            border = M.make_border({
                top = " Commit Description ",
                top_align = "left",
            }),
            win_options = M.win_options,
            enter = true
        }
    )

    local commit_msg = Popup({
        border = M.make_border({
            top = " Commit Body ",
            top_align = "left",
        }),
        win_options = M.win_options
    })


    local layout = Layout(
        {
            position = "50%",
            size = {
                width = 80,
                height = 40,
            },
        },
        Layout.Box({
            Layout.Box(commit_desc, { size = 3 }),
            Layout.Box(commit_msg, { size = "60%" }),
        }, { dir = "col" })
    )


    commit_msg:map("n", "<esc>", function(bufnr)
        commit_and_close(layout, commit_desc, commit_msg)
    end, { noremap = true, silent = true })

    commit_desc:map("n", "<esc>", function(bufnr)
        commit_and_close(layout, commit_desc, commit_msg)
    end, { noremap = true, silent = true })

    layout:mount()
end



M.mount_layout = function()
    M.make_git_commit_layout()
end


local get_modified_files = function()
    local files = {}
    local output = require("utils").run_command("git status --porcelain")
    if output then
        for file in output:gmatch(" M ([^\n]+)\n?") do
            table.insert(files, file)
        end
    end
    return files
end

local get_diff_for_file = function(file)
    local output = require("utils").run_command("git --no-pager diff " .. file)
    if output then
        return output
    end
    return nil
end

local diff_to_hunks = function(diff_str)
    local hunks = {}
    local file_header = ""
    local current_hunk = ""

    local passed_header = false
    for str in diff_str:gmatch("([^\n]*)\n?") do
        if not passed_header then
            if string.sub(str, 1, 2) == "@@" then
                passed_header = true
                current_hunk = str
            else
                file_header = file_header .. str .. "\n"
            end
        else

            if string.sub(str, 1, 2) == "@@" then
                local hunk = {}
                hunk["header"] = file_header
                hunk["raw"] = file_header .. current_hunk
                hunk["print"] = file_header .. current_hunk
                table.insert(hunks, hunk)

                current_hunk = str
            else
                current_hunk = current_hunk .. "\n" .. str
            end
        end

    end
    if current_hunk ~= "" then
        local hunk = {}
        hunk["header"] = file_header
        hunk["raw"] = file_header .. current_hunk
        hunk["print"] = file_header .. current_hunk
        table.insert(hunks, hunk)
    end
    return hunks
end

M.get_hunks = function()
    local hunks = {}
    local modified_files = get_modified_files()
    for _, file in ipairs(modified_files) do

        local diff = get_diff_for_file(file)
        if diff then
            local i = 0
            local raw_hunks = diff_to_hunks(diff)
            for _, h in ipairs(raw_hunks) do
                local new_hunk = {}
                new_hunk["file"] = file
                new_hunk["data"] = h
                new_hunk["index"] = i

                table.insert(hunks, new_hunk)
                i = i + 1
            end
        end
    end
    return hunks
end


return M
