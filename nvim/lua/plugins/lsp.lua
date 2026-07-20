-- Language Server Protocol (native vim.lsp.config + mason-lspconfig v2)
return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'b0o/schemastore.nvim',
    },
    config = function()
        require('mason').setup({
            registries = {
                'github:mason-org/mason-registry',
                -- Provides the 'roslyn' C# server package (see plugins/roslyn.lua)
                'github:Crashdummyy/mason-registry',
            },
        })

        -- TypeScript / JavaScript (Next.js, NestJS, serverless)
        local ts_settings = {
            complete_function_calls = true,
            vtsls = {
                enableMoveToFileCodeAction = true,
                autoUseWorkspaceTsdk = true,
                experimental = {
                    maxInlayHintLength = 30,
                    completion = {
                        enableServerSideFuzzyMatch = true,
                    },
                },
            },
            typescript = {
                updateImportsOnFileMove = { enabled = 'always' },
                suggest = { completeFunctionCalls = true },
                inlayHints = {
                    enumMemberValues = { enabled = true },
                    functionLikeReturnTypes = { enabled = true },
                    parameterNames = { enabled = 'literals' },
                    parameterTypes = { enabled = true },
                    propertyDeclarationTypes = { enabled = true },
                    variableTypes = { enabled = false },
                },
            },
        }
        ts_settings.javascript = vim.deepcopy(ts_settings.typescript)

        vim.lsp.config('vtsls', {
            filetypes = {
                'javascript',
                'javascriptreact',
                'javascript.jsx',
                'typescript',
                'typescriptreact',
                'typescript.tsx',
            },
            settings = ts_settings,
        })

        -- Python: pyright for types/navigation, ruff for lint/format/imports
        vim.lsp.config('pyright', {
            settings = {
                pyright = { disableOrganizeImports = true },
            },
        })

        vim.lsp.config('ruff', {
            init_options = { settings = { logLevel = 'error' } },
            on_attach = function(client)
                -- pyright owns hover
                client.server_capabilities.hoverProvider = false
            end,
        })

        -- JSON
        vim.lsp.config('jsonls', {
            settings = {
                json = {
                    schemas = require('schemastore').json.schemas(),
                    validate = { enable = true },
                },
            },
        })

        -- Emmet (HTML/CSS abbreviations)
        vim.lsp.config('emmet_ls', {
            filetypes = { 'html', 'css', 'javascriptreact', 'typescriptreact' },
        })

        -- Install servers and auto-enable them (automatic_enable is the default)
        require('mason-lspconfig').setup({
            ensure_installed = {
                'vtsls',
                'pyright',
                'ruff',
                'tailwindcss',
                'jsonls',
                'emmet_ls',
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
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = '',
                    [vim.diagnostic.severity.WARN] = '',
                    [vim.diagnostic.severity.INFO] = '',
                    [vim.diagnostic.severity.HINT] = '',
                },
            },
            underline = true,
            update_in_insert = false,
            severity_sort = true,
            float = {
                source = true,
                border = 'rounded',
            },
        })
    end,
}
