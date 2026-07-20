-- Automatic installation of formatters, linters, and DAP servers
return {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
        'williamboman/mason.nvim',
    },
    event = 'VeryLazy',
    cmd = { 'MasonToolsInstall', 'MasonToolsUpdate' },
    config = function()
        require('mason-tool-installer').setup({
            ensure_installed = {
                -- Formatters
                'prettier',       -- JS/TS/React/JSON/CSS/HTML/Markdown
                'stylua',         -- Lua formatter
                'shfmt',          -- Shell script formatter
                'csharpier',      -- C# formatter
                -- Note: ruff comes via mason-lspconfig (LSP + formatter in one)

                -- Linters
                'eslint_d',       -- JavaScript/TypeScript linter (faster than eslint)

                -- LSP servers outside mason-lspconfig
                'roslyn',         -- C# (Crashdummyy registry, used by roslyn.nvim)
            },
            auto_update = false,
            run_on_start = true,
        })
    end,
}
