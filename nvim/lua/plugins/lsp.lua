-- Language Server Protocol.
return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'b0o/schemastore.nvim',
        'jose-elias-alvarez/typescript.nvim',
    },
    config = function()
        -- Setup Mason to automatically install LSP servers
        require('mason').setup()
        require('mason-lspconfig').setup({ automatic_installation = true })

        local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
        local lspconfig = require('lspconfig');

        -- Angular
        lspconfig.angularls.setup({
            capabilities = capabilities,
            filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
            on_attach = function(client, bufnr)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end,
        })

        -- CSharp
        lspconfig.omnisharp.setup{
            cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
            enable_editorconfig_support = true,
            enable_roslyn_analyzers = true,
            organize_imports_on_format = true,
            enable_import_completion = true,
            capabilities = capabilities,
        }

        -- Python
        require('lspconfig').pyright.setup({
            capabilities = capabilities,
        })

        -- PHP
        lspconfig.intelephense.setup({
            capabilities = capabilities,
            filetypes = { 'php', 'blade' },
        })

        -- Typescript
        lspconfig.ts_ls.setup({
            capabilities = capabilities,
            init_options = {
                plugins = {
                    {
                        name = '@vue/typescript-plugin',
                        location = '/home/bryan/.nvm/versions/node/v18.20.4/lib/node_modules/@vue/typescript-plugin',
                        languages = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' }
                    }
                }
            },
            filetypes = {
                "javascript",
                "javascriptreact",
                "javascript.jsx",
                "typescript",
                "typescriptreact",
                "typescript.tsx",
                "vue"
            },
            cmd = { 'typescript-language-server', '--stdio' }
        })

        -- Tailwind CSS
        lspconfig.tailwindcss.setup({ capabilities = capabilities })

        -- JSON
        lspconfig.jsonls.setup({
            capabilities = capabilities,
            settings = {
                json = {
                    schemas = require('schemastore').json.schemas()
                },
            },
        })

        lspconfig.emmet_ls.setup({
            capabilities = capabilities,
            filetypes = { 'html', 'css', 'javascriptreact', 'typescriptreact', 'vue', 'svelte', 'angular' },
        })

        -- Keymaps
        vim.keymap.set('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
        vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
        vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
        vim.keymap.set('n', 'gi', ':Telescope lsp_implementations<CR>')
        vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>')
        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
        vim.keymap.set('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "Code Action" })
        vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, { desc = "Format" })

        -- Commands
        vim.api.nvim_create_user_command('Format', 'lua vim.lsp.buf.format()', {})

        -- Diagnostic configuration
        vim.diagnostic.config({
            virtual_text = true,
            float = {
                source = true,
            }
        })

        -- Sign configuration
        vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
        vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
        vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
        vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
    end,
}
