function entry_filter_function(entry, ctx)
    local kind = require('cmp.types').lsp.CompletionItemKind[entry:get_kind()]
    if (kind == 'Text')
    then
        return false
    elseif (kind == 'Snippet')
    then
        return false
    end
    return true
end

local cfg = {
    bind = true,
    wrap = true,
    floating_window = true,
    floating_window_above_cur_line = true,


    close_timeout = 1000,
    fix_pos = false,
    hint_enable = false,
    hi_parameter = "LspSignatureActiveParameter",
    handler_opts = {
        border = "rounded"
    },

    always_trigger = false,

    transparency = nil, -- disabled by default, allow floating win transparent value 1~100
    timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
    toggle_key = '<A-CR>', -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'

    select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
    move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
}
require "lsp_signature".setup(cfg)












local cmp = require 'cmp'

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
        format = require('lspkind').cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
        }),
    },

    matching = {
        disallow_fuzzy_matching = true,
    },

    mapping = cmp.mapping.preset.insert({
        ['<A-Up>'] = cmp.mapping.scroll_docs(-4),
        ['<A-Down>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources(
    --{ name = 'nvim_lsp_signature_help', priority = 8 },
        {
            {
                name = 'nvim_lsp',
                priority = 7,
                entry_filter = entry_filter_function
            },
        }, {
        { name = 'buffer',
            entry_filter = entry_filter_function },
    }),

    sorting = {
        priority_weight = 1.0,
        comparators = {
            cmp.config.compare.locality,
            cmp.config.compare.recently_used,
            cmp.config.compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
            cmp.config.compare.offset,
            cmp.config.compare.order,
        },
    },
    completion = { autocomplete = false }
})

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
