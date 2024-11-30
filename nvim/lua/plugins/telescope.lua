-- Fuzzy finder
return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'kyazdani42/nvim-web-devicons',
        'nvim-telescope/telescope-live-grep-args.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
        },
    },
    event = "VeryLazy",
    opts = {
        defaults = {
            path_display = { truncate = 1 },
            prompt_prefix = '   ',
            selection_caret = '  ',
            layout_config = {
                prompt_position = 'top',
            },
            sorting_strategy = 'ascending',
            file_ignore_patterns = { '.git/' },
        },
        pickers = {
            find_files = {
                hidden = true,
            },
            buffers = {
                previewer = false,
                layout_config = {
                    width = 80,
                },
            },
            oldfiles = {
                prompt_title = 'History',
            },
            lsp_references = {
                previewer = false,
            },
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = 'smart_case',
            },
        }
    },
    config = function(opts)
        require('telescope').setup(opts)
        require('telescope').load_extension('fzf')

        vim.keymap.set('n', '<leader>f', [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
        vim.keymap.set('n', '<leader>F', [[<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>]])
        vim.keymap.set('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
        vim.keymap.set('n', '<leader>gs', [[<cmd>lua require('telescope.builtin').git_status()<CR>]])
        vim.keymap.set('n', '<leader>gc', [[<cmd>lua require('telescope.builtin').git_bcommits()<CR>]])
        vim.keymap.set('n', '<leader>gb', [[<cmd>lua require('telescope.builtin').git_branches()<CR>]])
        vim.keymap.set('n', '<leader>h', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])
        vim.keymap.set('n', '<leader>s', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]])
    end,
}
