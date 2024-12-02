return {
    "folke/tokyonight.nvim",
    lazy = false,
    priotity = 1000,
    opts = {
        transparent = true,
        styles = {
            style = "storm",
            comments = { italic = true },
            keywords = { italic = true },
            functions = {},
            variable = {},
            sidebars = 'dark',
            floats = 'transparent,'
        },
        sidebars = { 'qf' },
    },
    init = function()
        vim.cmd([[colorscheme tokyonight]])
    end,
}
