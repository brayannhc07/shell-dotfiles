-- Language Server Protocol.
return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'b0o/schemastore.nvim',
        'jose-elias-alvarez/null-ls.nvim',
        'jayp0521/mason-null-ls.nvim',
    },
    config = function()
        -- Setup Mason to automatically install LSP servers
        require('mason').setup()
        require('mason-lspconfig').setup({ automatic_installation = true })

        local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

        -- Angular 
        require'lspconfig'.angularls.setup{}
        
        -- CSharp
        require'lspconfig'.csharp_ls.setup{}

        -- Python
        require('lspconfig').pyright.setup({
            capabilities = capabilities,
        })

        -- PHP
        require('lspconfig').intelephense.setup({
            capabilities = capabilities,
            filetypes = { 'php', 'blade' },
        })

        require('lspconfig').ts_ls.setup({
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

        -- Vue, JavaScript, TypeScript
        require('lspconfig').volar.setup({
            capabilities = capabilities,
            filetypes = { 'vue' },
        })
        -- Tailwind CSS
        require('lspconfig').tailwindcss.setup({ capabilities = capabilities })

        -- JSON
        require('lspconfig').jsonls.setup({
            capabilities = capabilities,
            settings = {
                json = {
                    schemas = require('schemastore').json.schemas()
                },
            },
        })

        -- null-ls
        require('null-ls').setup({
            sources = {
                require('null-ls').builtins.diagnostics.eslint_d.with({
                    condition = function(utils)
                        return utils.root_has_file({ '.eslintrc.js' })
                    end,
                }),
                require('null-ls').builtins.diagnostics.trail_space.with({ disabled_filetypes = { 'NvimTree' } }),
                require('null-ls').builtins.formatting.eslint_d.with({
                    condition = function(utils)
                        return utils.root_has_file({ '.eslintrc.js' })
                    end,
                }),
                require('null-ls').builtins.formatting.prettierd,
            },
        })
        require('mason-null-ls').setup({ automatic_installation = true })

        -- Keymaps
        vim.keymap.set('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
        vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
        vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
        vim.keymap.set('n', 'gi', ':Telescope lsp_implementations<CR>')
        vim.keymap.set('n', 'gr', ':Telescope lsp_references<CR>')
        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
        vim.keymap.set('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')

        -- Commands
        vim.api.nvim_create_user_command('Format', 'lua vim.lsp.buf.format()', {})

        -- Diagnostic configuration
        vim.diagnostic.config({
            virtual_text = false,
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