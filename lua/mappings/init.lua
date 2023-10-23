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

function Cycle_ai_assistant()
    if vim.g.codeium_enabled then
        vim.g.codeium_enabled = false
        vim.g.copilot_enabled = 1
    else
        if vim.g.copilot_enabled == 1 then
            vim.g.copilot_enabled = 0
        else
            vim.g.codeium_enabled = true
        end
    end
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
    Q = { "<cmd>q!<CR>", "Quit" },
    q = { "<cmd>Bdelete<CR>", "Close file" },
    e = { "<cmd>Neotree toggle<CR>", "Toggle file explorer" },
    ["/"] = { require("Comment.api").toggle.linewise.current, "Comment line" },

    x = { "<cmd>CellularAutomaton make_it_rain<CR>", "Ragequit" },
    A = { Cycle_ai_assistant, "Cycle AI assistant" },
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
        h = { "<cmd>Telescope git_hunks<CR>", "Stage Hunks" },
        c = { require("git_support").mount_layout, "Commit" },
        b = { "<cmd>BlamerToggle<CR>", "Toggle Inline Git blame" },
    }
}
wk.register(git_mappings, normal_opts)


-- Debuging mappings (using dapui and nvim-dap)
local debug_mappings = {
    y = {
        name = "Debug",
        --Breakpoints
        y = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Toggle breakpoint" },

        --Stepping
        u = { "<cmd>lua require('dap').continue()<CR>", "Continue" },
        i = { "<cmd>lua require('dap').step_into()<CR>", "Step into" },
        o = { "<cmd>lua require('dap').step_over()<CR>", "Step over" },
        O = { "<cmd>lua require('dap').step_out()<CR>", "Step out" },

        --Debugging controls
        s = { "<cmd>lua require('dap').continue()<CR>", "Start" },
        S = { "<cmd>lua require('dap').close()<CR>", "Stop" },
    }
}
wk.register(debug_mappings, normal_opts)

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

-- Keybindings for codeium, mimicking the copilot ones
-- vim.g.codeium_disable_bindings = 1
keymap("i", '<F8>', function() return vim.fn['codeium#Complete']() end, { expr = true })
keymap("i", '<F10>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true })
keymap("i", '<F9>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true })
keymap("i", '<Tab>', function() return vim.fn['codeium#Accept']() end, { expr = true })
