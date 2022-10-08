M = {}


M.setup = function()

    require "config.editor_ui.bufferline"
    require "config.editor_ui.lualine"


    require("scrollbar").setup()
end




return M
