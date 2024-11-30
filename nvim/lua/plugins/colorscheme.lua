return {
    "folke/tokyonight.nvim",
    lazy = false,
    priotity = 1000,
    opt = {
        style = 'night',
        transparent = true,
        italics = true,
        comments = true,
        darkSidebar = true,
    },
    config = function()
        vim.cmd([[colorscheme tokyonight]])
    end,
}
