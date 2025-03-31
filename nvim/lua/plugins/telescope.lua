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
    config = function()
        local actions = require('telescope.actions')

        vim.cmd([[
        highlight link TelescopePromptTitle PMenuSel
        highlight link TelescopePreviewTitle PMenuSel
        highlight link TelescopePromptNormal NormalFloat
        highlight link TelescopePromptBorder FloatBorder
        highlight link TelescopeNormal CursorLine
        highlight link TelescopeBorder CursorLineBg
        ]])

        require('telescope').setup({
            defaults = {
                path_display = { truncate = 1 },
                prompt_prefix = '   ',
                selection_caret = '  ',
                layout_config = {
                    prompt_position = 'top',
                },
                sorting_strategy = 'ascending',
                mappings = {
                    i = {
                        ['<esc>'] = actions.close,
                        ['<C-Down>'] = actions.cycle_history_next,
                        ['<C-Up>'] = actions.cycle_history_prev,
                    },
                },
                file_ignore_patterns = { '.git/' },
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
                buffers = {
                    previewer = true,
                },
                oldfiles = {
                    prompt_title = 'History',
                },
                lsp_references = {
                    previewer = true,
                },
            },
        })

        require('telescope').load_extension('fzf')
        require('telescope').load_extension('live_grep_args')
        local function get_visual_selection()
            local saved_reg = vim.fn.getreg('"')
            vim.cmd('normal! ""y')
            local selection = vim.fn.getreg('"')
            vim.fn.setreg('"', saved_reg)
            return selection
        end

        local function find_files_with_telescope()
            if vim.fn.mode() == "v" then
                -- If in Visual mode, get the selection and grep it
                local selection = get_visual_selection()
                require('telescope.builtin').find_files({ default_text = selection })
            else
                -- If in Normal mode, open find_files
                require('telescope.builtin').find_files()
            end
        end

        local function find_all_files_with_telescope()
            if vim.fn.mode() == "v" then
                -- If in Visual mode, get the selection and grep it
                local selection = get_visual_selection()
                require('telescope.builtin').find_files({ default_text = selection, no_ignore = true, prompt_title = 'All Files' })
            else
                -- If in Normal mode, open find_files
                require('telescope.builtin').find_files({ no_ignore = true, prompt_title = 'All Files' })
            end
        end

        local function live_grep_with_telescope()
            if vim.fn.mode() == "v" then
                -- If in Visual mode, get the selection and grep it
                local selection = get_visual_selection()
                require('telescope.builtin').live_grep({ default_text = selection })
            else
                -- If in Normal mode, open find_files
                require('telescope.builtin').live_grep()
            end
        end
        -- vim.keymap.set('n', '<leader>f', [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
        vim.keymap.set({ "n", "v" }, "<leader>f", find_files_with_telescope, { noremap = true, silent = true })
        vim.keymap.set({ 'n', 'v' }, '<leader>F', find_all_files_with_telescope, { noremap = true, silent = true })
        vim.keymap.set({ 'n', 'v' }, '<leader>G', live_grep_with_telescope, { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
        vim.keymap.set('n', '<leader>gs', [[<cmd>lua require('telescope.builtin').git_status()<CR>]])
        vim.keymap.set('n', '<leader>gc', [[<cmd>lua require('telescope.builtin').git_bcommits()<CR>]])
        vim.keymap.set('n', '<leader>gb', [[<cmd>lua require('telescope.builtin').git_branches()<CR>]])
        vim.keymap.set('n', '<leader>h', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])
        vim.keymap.set('n', '<leader>s', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]])
        vim.keymap.set('n', '<leader>tr', [[<cmd>lua require('telescope.builtin').resume()<CR>]])
    end,
}
