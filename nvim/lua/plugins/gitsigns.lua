-- Git Integration
return {
    'lewis6991/gitsigns.nvim',
    config = function()
        require('gitsigns').setup()
        vim.keymap.set('n', ']h', ':Gitsigns next_hunk<CR>')
        vim.keymap.set('n', '[h', ':Gitsigns prev_hunk<CR>')
        vim.keymap.set('n', 'gz', ':Gitsigns reset_hunk<CR>')
        vim.keymap.set('n', 'ga', ':Gitsigns stage_hunk<CR>')
        vim.keymap.set('n', 'gA', ':Gitsigns undo_stage_hunk<CR>')
        vim.keymap.set('n', 'gp', ':Gitsigns preview_hunk<CR>')
        vim.keymap.set('n', 'gb', ':Gitsigns blame_line<CR>')
    end,
}
