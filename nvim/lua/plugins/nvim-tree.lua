-- File tree sidebar
return {
    'kyazdani42/nvim-tree.lua',
    dependencies = {
        'kyazdani42/nvim-web-devicons'
    },
    cmd = { 'NvimTreeToggle', 'NvimTreeFindFileToggle' },
    keys = {
        { '<Leader>n', '<cmd>NvimTreeFindFileToggle<CR>', desc = 'File Tree' },
    },
    config = function()
        require('nvim-tree').setup({
            git = {
                ignore = false
            },
            renderer = {
                group_empty = true,
                icons = {
                    show = {
                        folder_arrow = false
                    },
                },
                indent_markers = {
                    enable = true,
                },
            },
            view = {
                width = 60,
            },
        })
    end,
}
