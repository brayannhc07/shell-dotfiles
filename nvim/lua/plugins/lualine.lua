-- A Status line
return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'kyazdani42/nvim-web-devicons',
    },
    event = 'VeryLazy',
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
                    'diff',
                    separator,
                    function()
                        return '🖧  ' .. #vim.lsp.get_clients({ bufnr = 0 })
                    end,
                    { 'diagnostics', sources = { 'nvim_diagnostic' } },
                    separator,
                    function()
                        local ok, status = pcall(vim.api.nvim_call_function, "codeium#GetStatusString", {})
                        if ok then
                            return " " .. status
                        else
                            return ''
                        end
                    end,
                },
                lualine_c = {
                    'filename'
                },
                lualine_x = {
                    'filetype',
                    -- only shown when the value is abnormal (non-utf8, CRLF)
                    {
                        'encoding',
                        cond = function()
                            local enc = vim.opt.fileencoding:get()
                            return enc ~= '' and enc ~= 'utf-8'
                        end,
                    },
                    {
                        'fileformat',
                        cond = function()
                            return vim.bo.fileformat ~= 'unix'
                        end,
                    },
                },
                lualine_y = {},
                lualine_z = {
                    'location',
                },
            },
        })
    end,
}
