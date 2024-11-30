-- Display indentation lines.
return {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
        require('ibl').setup({
            exclude = {
                filetypes = {
                    'help',
                    'terminal',
                    'dashboard',
                    'packer',
                    'lspinfo',
                    'TelescopePrompt',
                    'TelescopeResults',
                },
                buftypes = {
                    'terminal',
                    'NvimTree',
                },
            }
        })
    end,
}
