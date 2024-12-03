return {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    priotity = 1000,
    config = function()
        require("monokai-pro").setup({
            transparent_background = true,
            terminal_colors = true,
            devicons = true,
            filter = "pro",
            plugins = {
                indent_blankline = {
                    context_highlight = "pro",
                    context_start_underline = true,
                },
            },
            overridePalette = function(filter)
                return {
                    accent1 = "#F97BB0",
                    accent2 = "#82E6FF",
                    accent3 = "#D7C781",
                    accent4 = "#75C2B3",
                    accent5 = "#5AD4E6",
                    accent6 = "#948AE3",
                    white = "#F7F1FF",
                }
            end
        })
        vim.cmd([[colorscheme monokai-pro]])
    end,
}
