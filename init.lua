vim.api.nvim_command('set termguicolors')


local utils = require("utils")
local has_user_config = utils.prequire("user")

local user_config = {}
if has_user_config then
    user_config = require("user")
end
user_config = utils.sanitize_config(user_config)

require "setup"


require("config").setup(user_config)

require "mappings"


-- Disable Copilot by default
vim.g.copilot_enabled = 0
vim.g.codeium_enabled = false

-- Commands/Whichkey related
vim.g.mapleader       = " "
vim.opt.timeoutlen    = 300

-- Display absolute line numbers
vim.opt.number        = true

-- Tabs
vim.opt.tabstop       = 4
vim.opt.softtabstop   = 4
vim.opt.shiftwidth    = 4
vim.api.nvim_command('set expandtab')

-- Mouse support
vim.api.nvim_command('set mouse=nvi')

-- Select virutal text as the default diagnostic visualization
require("utils").diagnostics_as_virtual_text()

vim.fn.sign_define("DiagnosticSignError",
    { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn",
    { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo",
    { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint",
    { text = "", texthl = "DiagnosticSignHint" })

require("themer").setup({
    colorscheme = user_config.colorscheme
})
