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

return M
