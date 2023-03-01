-- Setup mapping for various plugins
local wk = require("which-key")

local normal_opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
}


local visual_opts = {
    mode = "v", -- VISUAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
}



local lsp_mappings_normal = {
    l = {
        name = "Language Server tools",

        f = { "<cmd>Lspsaga lsp_finder<CR>", "Find symbol" },
        a = { "<cmd>Lspsaga code_action<CR>", "Code action" },
        r = { "<cmd>Lspsaga rename<CR>", "Rename symbol" },
        p = { "<cmd>Lspsaga peek_definition<CR>", "Peek definition" },
        o = { "<cmd>Lspsaga outline<CR>", "Show buffer outline" },
        d = { "<cmd>Lspsaga hover_doc<CR>", "Show documentation" },
    }
}

local lsp_mappings_visual = {
    l = {
        name = "Language Server tools",

        a = { "<cmd>Lspsaga code_action<CR>", "Code action" }
    }
}

wk.register(lsp_mappings_normal, normal_opts)
wk.register(lsp_mappings_visual, visual_opts)


local utils = require("utils")

local diagnostics_mappings = {
    D = {
        name = "Diagnostics",
        t = { utils.diagnostics_as_virtual_text, "Diagnostics as virtual text" },
        l = { utils.diagnostics_as_virtual_lines, "Diagnostics as virtual lines" },
        S = { utils.toggle_diagnostic_virtual_lines, "Switch diagnostics representation" },
        T = { "<cmd>:TroubleToggle<CR>", "Toggle diagnostics window" }
    },
}

wk.register(diagnostics_mappings, normal_opts)

local misc_mappings_normal = {
    w = { "<cmd>w<CR>", "Save file" },
    q = { "<cmd>q!<CR>", "Quit" },
    d = { "<cmd>Bdelete<CR>", "Close file" },
    e = { "<cmd>Neotree toggle<CR>", "Toggle file explorer" },
    A = { "<cmd>Alpha<CR>", "Toggle Alpha dashboard" },
    ["/"] = { require("Comment.api").toggle.linewise.current, "Comment line" },
}
wk.register(misc_mappings_normal, normal_opts)


local git_mappings = {
    g = {
        name = "Git",
        b = { "<cmd>Telescope git_branches<CR>", "Search Branches" },
        L = { "<cmd>Telescope git_bcommits<CR>", "Search Buffer commits" },
        l = { "<cmd>Telescope git_commits<CR>", "Search Commits" },
        S = { "<cmd>Telescope git_branches<CR>", "Search Stashes" },
        s = { "<cmd>Telescope git_status<CR>", "Status" },
        h = { "<cmd>Telescope git_hunks<CR>", "Stage Hunks" },
        c = { require("git_support").mount_layout, "Commit" }
    }
}
wk.register(git_mappings, normal_opts)


local copilot_mappings = {
    C = {
        name = "Copilot",
        e = { "<cmd>let g:copilot_enabled = 1<CR>", "Enable copilot" },
        d = { "<cmd>let g:copilot_enabled = 0<CR>", "Disable copilot" },
        p = { "<cmd>Copilot panel<CR>", "Open copilot panel" },
        o = { "<cmd>Copilot open<CR>", "Open copilot in a new window" },
    }
}
wk.register(copilot_mappings, normal_opts)



local esc = vim.api.nvim_replace_termcodes(
    '<ESC>', true, false, true
)

function comment_blockwise()
    vim.api.nvim_feedkeys(esc, 'nx', false)
    require("Comment.api").toggle.blockwise(vim.fn.visualmode())
end

function comment_linewise()
    vim.api.nvim_feedkeys(esc, 'nx', false)
    require("Comment.api").toggle.linewise(vim.fn.visualmode())
end

local misc_mappings_visual = {
    ["\\"] = { comment_blockwise, "Comment selection (blockwise)" },
    ["/"] = { comment_linewise, "Comment selection (linewise)" },
}
wk.register(misc_mappings_visual, visual_opts)


local keymap = vim.keymap.set
keymap("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { silent = true, desc = "Previous Tab" })
keymap("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { silent = true, desc = "Next Tab" })

keymap("n", "<C-h>", "<cmd>wincmd h<CR>", { silent = true, desc = "Goto left window" })
keymap("n", "<C-l>", "<cmd>wincmd l<CR>", { silent = true, desc = "Goto right window" })
keymap("n", "<C-j>", "<cmd>wincmd j<CR>", { silent = true, desc = "Goto top window" })
keymap("n", "<C-k>", "<cmd>wincmd k<CR>", { silent = true, desc = "Goto bottom window" })

-- Triggers copilot suggestion with Alt + space
keymap("i", "<F8>", "<Plug>(copilot-suggest)", { silent = true, desc = "Trigger copilot suggestion" })
keymap("i", "<F10>", "<Plug>(copilot-next)", { silent = true, desc = "Next copilot suggestion" })
keymap("i", "<F9>", "<Plug>(copilot-previous)", { silent = true, desc = "Previous copilot suggestion" })
