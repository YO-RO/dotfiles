-- main colorscheme は { lazy = false, priority = 1000, } に変更必要がある。
-- また、config 内で vim.cmd("colorscheme {main colorscheme name}") を実行する必要がある。
return {
    -- {
    --     "RRethy/base16-nvim",
    --     event = "VeryLazy",
    --     config = function(_, _)
    --         require("base16-colorscheme").with_config({
    --             telescope = true,
    --             cmp = true,
    --         })
    --     end,
    -- },
    {
        "catppuccin/nvim",
        name = "catppuccin", -- name of local dir
        lazy = false,
        priority = 1000,
        config = function(_, opts)
            require("catppuccin").setup(opts)

            vim.cmd.colorscheme("catppuccin")
        end,
        opts = {
            -- flavour = "latte",
            dim_inactive = {
                enabled = true,
                shade = "dark",
                percentage = 0.1,
            },
            custom_highlights = function(colors)
                return {
                    Comment = { fg = colors.overlay2 },

                    Cursor = { fg = colors.crust, bg = colors.rosewater },
                    lCursor = { fg = colors.crust, bg = colors.rosewater },
                    CursorIM = { fg = colors.crust, bg = colors.red },

                    LineNr = { fg = colors.overlay1 }
                }
            end,
            integrations = {
                aerial = true,
                alpha = true,
                cmp = true,
                dashboard = true,
                flash = true,
                gitsigns = true,
                headlines = true,
                illuminate = true,
                indent_blankline = { enabled = true },
                leap = true,
                lsp_trouble = true,
                mason = true,
                markdown = true,
                mini = true,
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                },
                navic = { enabled = true, custom_bg = "lualine" },
                neotest = true,
                neotree = true,
                noice = true,
                notify = true,
                semantic_tokens = true,
                telescope = true,
                treesitter = true,
                treesitter_context = true,
                which_key = true,
            },
        },
    },
}
