require('bufferline').setup {
    options = {
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        numbers = "none",
        close_command = "Bdelete! %d",
        middle_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
        left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
        right_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
        buffer_close_icon = '',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',


        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        truncate_names = false, -- whether or not tab names should be truncated
        tab_size = 18,
        offsets = {
            {
                filetype = "neo-tree",
                text = "File Explorer",
                text_align = "center",
                separator = true,
            }
        },
        color_icons = true, -- whether or not to add the filetype icon highlights
        show_tab_indicators = true,
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        show_close_icon = false,
    }
}

-- FIXME: Bufferline change icons based on the filetype. Filetype for hpp files is cpp so they are shown with the C++ icon
-- rather than being shown with the Hpp icon as you would expect.
-- This particularly annoying because neo-tree and lualine are able to do the difference properly.
