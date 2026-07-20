-- Completion
return {
    'saghen/blink.cmp',
    version = '1.*', -- pin: the main branch is v2 with breaking changes
    event = 'InsertEnter',
    dependencies = {
        'L3MON4D3/LuaSnip',
    },
    opts = {
        keymap = {
            preset = 'enter', -- <CR> accepts (first item preselected)
            ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
            ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
            ['<C-k>'] = false, -- preset binds signature toggle; keep LuaSnip's <C-k>
        },
        snippets = { preset = 'luasnip' },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        appearance = {
            nerd_font_variant = 'mono',
        },
        cmdline = { enabled = false },
    },
    opts_extend = { 'sources.default' },
}
