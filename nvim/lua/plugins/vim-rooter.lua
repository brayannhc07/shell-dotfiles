-- Automatically set the working directory to the project root.
return {
    "airblade/vim-rooter",
    config = function()
        vim.cmd('Rooter')
    end,
    init = function()
        -- Instead of this running every time we open a file, we just run it once when Vim starts.
        vim.g.rooter_manual_only = 1
    end,
}
