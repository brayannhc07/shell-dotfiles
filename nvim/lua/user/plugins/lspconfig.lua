-- Setup Mason to automatically install LSP servers
require('mason').setup()
require('mason-lspconfig').setup({ automatic_installation = true })

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

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

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.blade.php",
    callback = function()
        -- Ensure the LSP is properly loaded before accessing its methods
        local lspconfig = require 'lspconfig'
        
        -- Only change the filetype if it's not already set to PHP
        if vim.bo.filetype ~= "php" then
            vim.bo.filetype = "php"

            -- Check for active LSP clients for the current buffer
            local clients = vim.lsp.get_active_clients({ bufnr = 0 })
            if #clients == 0 then
                -- Try to attach Intelephense
                local success, err = pcall(function()
                    lspconfig.intelephense.manager.try_add()
                end)

                -- Handle any errors during the attachment
                if not success then
                    print("LSP Error: " .. err)  -- Print the error message if there's an issue
                end
            end
        end
    end,
})

