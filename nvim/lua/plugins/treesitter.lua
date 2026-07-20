-- Improved syntax highlighting
return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master', -- frozen branch; the main-branch rewrite is a future migration
    build = ":TSUpdate",
    dependencies = {
        { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'master' },
    },
    event = "VeryLazy",
    main = "nvim-treesitter.configs",
    opts = {
        ensure_installed = {
            "bash",
            "css",
            "c_sharp",
            "html",
            "javascript",
            "json",
            "lua",
            "luadoc",
            "query",
            "sql",
            "typescript",
            "regex",
            "vim",
            "yaml",
            "python",
        },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
            disable = { "markdown", "markdown_inline" },
        },
        indent = {
            enable = true,
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@conditional.outer",
                    ["ic"] = "@conditional.inner",
                    ["al"] = "@loop.outer",
                    ["il"] = "@loop.inner",
                },
            }
        }
    },
}
