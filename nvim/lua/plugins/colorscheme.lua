return {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        transparent = true,
    },
    init = function()
        vim.cmd[[colorscheme monokai-pro-spectrum]]
    end,
}
