-- A Status line
return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'kyazdani42/nvim-web-devicons',
    },
    config = function()
        local separator = { '"▏"', color = 'StatusLineNonText' }

        require('lualine').setup({
            options = {
                section_separators = '',
                component_separators = '',
                globalstatus = true,
            },
            sections = {
                lualine_a = {
                    'mode',
                    separator,
                },
                lualine_b = {
                    'branch',
                    'diff',
                    separator,
                    '"🖧  " .. tostring(#vim.tbl_keys(vim.lsp.get_clients()))',
                    { 'diagnostics', sources = { 'nvim_diagnostic' } },
                    separator,
                    function()
                        local ok, status = pcall(vim.api.nvim_call_function, "codeium#GetStatusString", {})
                        if ok then
                            return " " .. status
                        else
                            return " N/A"
                        end
                    end,
                },
                lualine_c = {
                    'filename'
                },
                lualine_x = {
                    'filetype',
                    'encoding',
                    'fileformat',
                },
                lualine_y = {
                    separator,
                    '(vim.bo.expandtab and "␠ " or "⇥ ") .. " " .. vim.bo.shiftwidth',
                    separator,
                },
                lualine_z = {
                    'location',
                    'progress',
                },
            },
        })
    end,
}
