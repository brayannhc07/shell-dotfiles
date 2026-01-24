-- Formatting plugin with conform.nvim
return {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
        local conform = require('conform')

        conform.setup({
            formatters_by_ft = {
                -- JavaScript/TypeScript/React (Next.js)
                javascript = { 'prettier' },
                javascriptreact = { 'prettier' },
                typescript = { 'prettier' },
                typescriptreact = { 'prettier' },

                -- Web technologies
                html = { 'prettier' },
                css = { 'prettier' },
                scss = { 'prettier' },
                json = { 'prettier' },
                jsonc = { 'prettier' },
                yaml = { 'prettier' },
                markdown = { 'prettier' },

                -- Python
                python = { 'black', 'isort' },

                -- PHP/Laravel
                php = { 'php_cs_fixer' },

                -- C#
                cs = { 'csharpier' },

                -- Shell
                bash = { 'shfmt' },
                sh = { 'shfmt' },

                -- Lua
                lua = { 'stylua' },
            },

            -- Format on save (disabled - use <leader>cf to format manually)
            -- format_on_save = {
            --     timeout_ms = 500,
            --     lsp_fallback = true,
            -- },

            -- Customize formatters
            formatters = {
                black = {
                    prepend_args = { '--line-length', '88' },
                },
                prettier = {
                    prepend_args = { '--tab-width', '2', '--single-quote' },
                },
            },
        })

        -- Keybindings
        vim.keymap.set({ 'n', 'v' }, '<leader>cf', function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end, { desc = 'Format file or selection' })
    end,
}
