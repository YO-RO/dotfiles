return {
    {
        -- Colorscheme
        "catppuccin/nvim",
        name = "catppuccin", -- name of local dir
        lazy = false,
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd("colorscheme catppuccin")
        end,
        opts = {
            dim_inactive = {
                enabled = true,
                shade = "light",
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
    {
        -- File explorer
        'stevearc/oil.nvim',
        lazy = false,
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "<leader>e", "<cmd>Oil<cr>", desc = "Open file explorer" },
        },
    },
    {
        -- Center windows
        "shortcuts/no-neck-pain.nvim",
        event = "UIEnter",
        version = "*",
        config = function(_, opts)
            require("no-neck-pain").setup(opts)
            vim.cmd("NoNeckPain")
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {},
    },
    {
        -- Make indents easier to see
        "shellRaining/hlchunk.nvim",
        event = "VeryLazy",
        opts = {
            chunk = {
                style = {
                    -- Catppuccin.Mocha.Overlay0
                    { fg = "#6c7086" },
                    -- Catppuccin.Mocha.Maroon
                    { fg = "#eba0ac" },
                },
            },
            indent = { enable = false },
            line_num = { enable = false },
            blank = { enable = false },
        },
    },
    {
        -- Display file name
        'b0o/incline.nvim',
        event = 'VeryLazy',
        config = true,
    },
}
