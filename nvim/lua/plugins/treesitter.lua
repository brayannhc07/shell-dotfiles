-- Improved syntax highlighting
return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    dependencies = {
        'JoosepAlviste/nvim-ts-context-commentstring',
        'nvim-treesitter/nvim-treesitter-textobjects',
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
            "php",
            "phpdoc",
            "query",
            "sql",
            "typescript",
            "regex",
            "vim",
            "vue",
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
    config = function(plug, config)
        local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
        parser_config.blade = {
            install_info = {
                url = "https://github.com/EmranMR/tree-sitter-blade",
                files = {"src/parser.c"},
                branch = "main",
            },
            filetype = "blade"
        }

        vim.filetype.add({
            pattern = {
                ['.*%.blade%.php'] = 'blade',
            },
        })

        require(plug.main).setup(config);
    end,
}
