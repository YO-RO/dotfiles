return {
    {
        "nvim-treesitter/nvim-treesitter",
        main = "nvim-treesitter.configs",
        build = ":TSUpdate",
        event = "VeryLazy",
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall", },
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        opts = {
            ensure_installed = {
                "bash",
                "dart",
                "tmux",
                "lua",
                "go",
                "python",
                "rust",
                "make",
                "sql",
                "jsonc",
                "toml",
                "markdown",
                "markdown_inline",
                "vimdoc",
            },
            highlight = { enable = true, },
            indent = { enable = true, },
            incremental_selection = { enable = false, },

            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                    },
                },
                move = {
                    enable = true,
                    goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
                    goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
                    goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
                    goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
                },
            },
        },
    },
}
