return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        lazy = false,
        build = ':TSUpdate',
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function(_, opts)
            local langs = {
                "bash",
                "zsh",
                "c",
                "dart",
                "tmux",
                "lua",
                "go",
                "python",
                "rust",
                "make",
                "sql",
                "json",
                "toml",
                "yaml",
                "markdown",
                "markdown_inline",
                "html",
                "htmldjango",
                "css",
                "javascript",
                "typescript",
                "vimdoc",
            }

            local nvim_treesitter = require('nvim-treesitter')
            nvim_treesitter.setup(opts)
            nvim_treesitter.install(langs)

            local group = vim.api.nvim_create_augroup('nvim-treesitter-augroup', { clear = true })
            vim.api.nvim_create_autocmd('FileType', {
                group = group,
                pattern = langs,
                callback = function()
                    vim.treesitter.start()
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        init = function()
            -- Disable entire built-in ftplugin mappings to avoid conflicts.
            -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
            vim.g.no_plugin_maps = true

            -- Or, disable per filetype (add as you like)
            -- vim.g.no_python_maps = true
            -- vim.g.no_ruby_maps = true
            -- vim.g.no_rust_maps = true
            -- vim.g.no_go_maps = true
        end,
        config = function()
            require("nvim-treesitter-textobjects").setup {
                select = {
                    lookahead = true,
                    selection_modes = {
                        ['@parameter.outer'] = 'v', -- charwise
                        ['@function.outer'] = 'V',  -- linewise
                        ['@class.outer'] = '<c-v>', -- blockwise
                    },
                },
                move = {
                    set_jumps = true,
                },
            }

            -- SELECTION
            vim.keymap.set({ "x", "o" }, "af", function()
                require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "if", function()
                require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ac", function()
                require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "x", "o" }, "ic", function()
                require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
            end)

            -- MOVE
            vim.keymap.set({ "n", "x", "o" }, "]f", function()
                require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]F", function()
                require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[f", function()
                require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[F", function()
                require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]c", function()
                require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "]C", function()
                require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[c", function()
                require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
            end)
            vim.keymap.set({ "n", "x", "o" }, "[C", function()
                require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
            end)
        end,
    },
    -- {
    --     "nvim-treesitter/nvim-treesitter",
    --     main = "nvim-treesitter.configs",
    --     build = ":TSUpdate",
    --     event = "VeryLazy",
    --     cmd = { "TSUpdateSync", "TSUpdate", "TSInstall", },
    --     dependencies = {
    --         "nvim-treesitter/nvim-treesitter-textobjects",
    --     },
    --     opts = {
    --         ensure_installed = {
    --             "bash",
    --             "c",
    --             "dart",
    --             "tmux",
    --             "lua",
    --             "go",
    --             "python",
    --             "rust",
    --             "make",
    --             "sql",
    --             "jsonc",
    --             "toml",
    --             "yaml",
    --             "markdown",
    --             "markdown_inline",
    --             "html",
    --             "htmldjango",
    --             "css",
    --             "javascript",
    --             "typescript",
    --             "vimdoc",
    --         },
    --         highlight = { enable = true, },
    --         indent = { enable = true, },
    --         incremental_selection = { enable = false, },
    --
    --         textobjects = {
    --             select = {
    --                 enable = true,
    --                 lookahead = true,
    --                 keymaps = {
    --                     ["af"] = "@function.outer",
    --                     ["if"] = "@function.inner",
    --                     ["ac"] = "@class.outer",
    --                     ["ic"] = "@class.inner",
    --                 },
    --             },
    --             move = {
    --                 enable = true,
    --                 goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
    --                 goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
    --                 goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
    --                 goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
    --             },
    --         },
    --     },
    -- },
}
