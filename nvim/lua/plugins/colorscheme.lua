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
            override = function(c)
                return {
                    -- Snacks indent guides: theme only defines the rainbow variants,
                    -- so these fall back to NonText/Special (too bright). Use the
                    -- same dim grays the indent-blankline integration used.
                    SnacksIndent = { fg = c.editorIndentGuide.background },
                    SnacksIndentScope = { fg = c.editorIndentGuide.activeBackground },
                }
            end,
        })
        vim.cmd[[colorscheme monokai-pro]]
    end,
}
