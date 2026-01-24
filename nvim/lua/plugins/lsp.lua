-- Language Server Protocol (Neovim 0.11+ compatible)
return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'b0o/schemastore.nvim',
    },
    config = function()
        -- Setup Mason to automatically install LSP servers
        require('mason').setup()

        -- Get capabilities for autocompletion
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        -- Configure individual servers with custom settings
        local server_configs = {
            -- C# / ASP.NET
            omnisharp = {
                cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
                capabilities = capabilities,
                settings = {
                    FormattingOptions = {
                        EnableEditorConfigSupport = true,
                        OrganizeImports = true,
                    },
                    RoslynExtensionsOptions = {
                        EnableAnalyzersSupport = true,
                        EnableImportCompletion = true,
                    },
                },
            },

            -- Python
            pyright = {
                capabilities = capabilities,
                on_attach = function(client)
                    -- Disable formatting in favor of black (via conform.nvim)
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end,
            },

            -- PHP / Laravel
            intelephense = {
                capabilities = capabilities,
                filetypes = { 'php', 'blade' },
                on_attach = function(client)
                    -- Disable formatting in favor of php-cs-fixer (via conform.nvim)
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end,
            },

            -- TypeScript / JavaScript / React (Next.js)
            ts_ls = {
                capabilities = capabilities,
                filetypes = {
                    "javascript",
                    "javascriptreact",
                    "javascript.jsx",
                    "typescript",
                    "typescriptreact",
                    "typescript.tsx",
                },
                on_attach = function(client)
                    -- Disable formatting in favor of prettier (via conform.nvim)
                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false
                end,
            },

            -- Tailwind CSS
            tailwindcss = {
                capabilities = capabilities,
            },

            -- JSON
            jsonls = {
                capabilities = capabilities,
                settings = {
                    json = {
                        schemas = require('schemastore').json.schemas(),
                        validate = { enable = true },
                    },
                },
            },

            -- Emmet (HTML/CSS abbreviations)
            emmet_ls = {
                capabilities = capabilities,
                filetypes = { 'html', 'css', 'javascriptreact', 'typescriptreact' },
            },
        }

        -- Setup mason-lspconfig with automatic server configuration
        require('mason-lspconfig').setup({
            ensure_installed = vim.tbl_keys(server_configs),
            automatic_installation = true,
            handlers = {
                -- Default handler for all servers
                function(server_name)
                    local config = server_configs[server_name] or {}
                    require('lspconfig')[server_name].setup(config)
                end,
            },
        })

        -- Keymaps (set up after LSP attaches)
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                local opts = { buffer = ev.buf }

                -- Navigation
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
                vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

                -- Code actions
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

                -- Diagnostics
                vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)
                vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
                vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
            end,
        })

        -- Diagnostic configuration
        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,
            float = {
                source = true,
                border = 'rounded',
            },
        })

        -- Sign configuration
        local signs = {
            Error = '',
            Warn = '',
            Info = '',
            Hint = '',
        }

        for type, icon in pairs(signs) do
            local hl = 'DiagnosticSign' .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end
    end,
}
