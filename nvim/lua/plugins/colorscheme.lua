return {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("monokai-pro").setup({
            transparent_background = true,
            filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum | light
            -- Disable nvim-tree integration (has bg_base compatibility issue with Neovim 0.11+)
            disabled_plugins = { "nvim-tree/nvim-tree.lua" },
        })
        vim.cmd[[colorscheme monokai-pro]]
    end,
}
