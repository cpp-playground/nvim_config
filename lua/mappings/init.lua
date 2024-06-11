-- Setup mapping for various plugins
local wk = require("which-key")

local normal_opts = {
    mode = "n",     -- NORMAL mode
    prefix = "<leader>",
    buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
}


local visual_opts = {
    mode = "v",     -- VISUAL mode
    prefix = "<leader>",
    buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
}


function toggle_hints()
    enabled = vim.lsp.inlay_hint.is_enabled()
    vim.lsp.inlay_hint.enable(0, not enabled)
end

local lsp_mappings_normal = {
    l = {
        name = "Language Server tools",

        f = { "<cmd>Lspsaga finder<CR>", "Find symbol" },
        a = { "<cmd>Lspsaga code_action<CR>", "Code action" },
        r = { "<cmd>Lspsaga rename<CR>", "Rename symbol" },
        g = { "<cmd>Lspsaga goto_definition<CR>", "Go to definition" },
        p = { "<cmd>Lspsaga peek_definition<CR>", "Peek definition" },
        o = { "<cmd>Lspsaga outline<CR>", "Show buffer outline" },
        d = { "<cmd>Lspsaga hover_doc<CR>", "Show documentation" },

        F = {
            name = "Search",
            --Telescope based mappings
            s = { "<cmd>Telescope lsp_document_symbols<CR>", "Document symbols" },
            S = { "<cmd>Telescope lsp_workspace_symbols<CR>", "Workspace symbols" },
        },

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

-- Telescope mappings
local telescope_mappings = {
    f = {
        name = "Find",
        f = { "<cmd>Telescope find_files<CR>", "File name" },
        g = { "<cmd>Telescope live_grep<CR>", "File content" },
        b = { "<cmd>Telescope buffers<CR>", "Openned files" },
    }
}
wk.register(telescope_mappings, normal_opts)


local misc_mappings_normal = {
    w = { "<cmd>w<CR>", "Save file" },
    Q = { "<cmd>q!<CR>", "Quit" },
    q = { "<cmd>Bdelete<CR>", "Close file" },
    e = { "<cmd>Neotree toggle<CR>", "Toggle file explorer" },
    ["/"] = { require("Comment.api").toggle.linewise.current, "Comment line" },
    D = {"<cmd>:TroubleToggle<CR>", "Toggle Diagnostics window"},
    h = { toggle_hints, "Toggle inlay hints" }
}
wk.register(misc_mappings_normal, normal_opts)


local git_mappings = {
    g = {
        name = "Git",
        B = { "<cmd>Telescope git_branches<CR>", "Search Branches" },
        L = { "<cmd>Telescope git_bcommits<CR>", "Search Buffer commits" },
        l = { "<cmd>Telescope git_commits<CR>", "Search Commits" },
        S = { "<cmd>Telescope git_branches<CR>", "Search Stashes" },
        s = { "<cmd>Telescope git_status<CR>", "Status" },
        b = { "<cmd>BlameToggle virtual<CR>", "Toggle Git blame virtual text" },
        g = { "<cmd>BlameToggle<CR>", "Toggle Git blame" },
    }
}
wk.register(git_mappings, normal_opts)


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

