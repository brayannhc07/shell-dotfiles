local group = vim.api.nvim_create_augroup('UserAutocmds', { clear = true })

-- Reload buffers changed on disk by another program (e.g. Claude Code in the
-- other tmux pane). Requires tmux focus-events, already on in tmux.conf.
-- Deliberately NOT on BufEnter: checktime stats every buffer synchronously,
-- which is slow on /mnt/c (9p) and adds latency to every buffer switch.
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
    group = group,
    callback = function()
        if vim.o.buftype ~= 'nofile' then
            vim.cmd('checktime')
        end
    end,
})

vim.api.nvim_create_autocmd('FileChangedShellPost', {
    group = group,
    callback = function()
        vim.notify('File changed on disk. Buffer reloaded.')
    end,
})

-- Briefly highlight yanked text.
vim.api.nvim_create_autocmd('TextYankPost', {
    group = group,
    callback = function()
        vim.hl.on_yank()
    end,
})
