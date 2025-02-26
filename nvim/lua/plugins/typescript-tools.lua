return {
    'pmizio/typescript-tools.nvim',
    dependencies = {},
    config = function()
        require('typescript-tools').setup({
            capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
            settings = {
                tsserver_plugins = {
                  name = "@angular/language-service",
                }
            }
        })
    end,
}
