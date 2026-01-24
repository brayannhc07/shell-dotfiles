-- Automatic installation of formatters, linters, and DAP servers
return {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
        'williamboman/mason.nvim',
    },
    config = function()
        require('mason-tool-installer').setup({
            ensure_installed = {
                -- Formatters
                'prettier',       -- JS/TS/React/JSON/CSS/HTML/Markdown
                'black',          -- Python formatter
                'isort',          -- Python import sorter
                'stylua',         -- Lua formatter
                'shfmt',          -- Shell script formatter
                'csharpier',      -- C# formatter
                -- Note: php-cs-fixer needs to be installed separately via composer

                -- Linters
                'eslint_d',       -- JavaScript/TypeScript linter (faster than eslint)
                'pylint',         -- Python linter
            },
            auto_update = false,
            run_on_start = true,
        })
    end,
}
