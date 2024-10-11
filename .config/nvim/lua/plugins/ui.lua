-- main colorscheme は { lazy = false, priority = 1000, } に変更必要がある。
-- また、config 内で vim.cmd("colorscheme {main colorscheme name}") を実行する必要がある。
return {
    {
        -- Colorscheme
        "RRethy/base16-nvim",
        event = "VeryLazy",
        -- lazy = false,
        -- priority = 1000,
        config = function(_, _)
            require("base16-colorscheme").with_config({
                telescope = true,
                cmp = true,
            })

            -- vim.cmd("colorscheme base16-tokyo-night-light")
        end,
    },
    {
        -- Colorscheme
        "folke/tokyonight.nvim",
        -- event = "VeryLazy",
        lazy = false,
        priority = 1000,
        config = function(_, opts)
            require("tokyonight").setup(opts)

            vim.cmd.colorscheme("tokyonight")
        end,
        opts = {
            style = "moon",
            light_style = "day",
            dim_inactive = false,
        },
    },
    {
        -- Colorscheme
        "catppuccin/nvim",
        name = "catppuccin", -- name of local dir
        event = "VeryLazy",
        -- lazy = false,
        -- priority = 1000,
        config = function(_, opts)
            require("catppuccin").setup(opts)

            -- vim.cmd.colorscheme("catppuccin")
        end,
        opts = {
            flavour = "latte",
            dim_inactive = {
                enabled = true,
                shade = "dark",
                percentage = 0.15,
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
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        opts = {
            signs = {
                add = { text = "+" },
            },
        },
    },
    {
        -- Center windows
        "shortcuts/no-neck-pain.nvim",
        version = "*",
        keys = {
            { "<leader>n", "<cmd>NoNeckPain<CR>", desc = "NoNeckPain" },
        },
        config = true,
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
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            chunk = {
                enable = true,
                delay = 0, -- 0 disables animation
            },
            indent = { enable = false },
            line_num = { enable = false },
            blank = { enable = false },
        },
    },
    {
        -- Status Line
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        opts = {
            options = {
                theme = "auto",
                section_separators = '',
                component_separators = '',
            },
            sections = {
                lualine_a = { 'filename' },
                lualine_b = { 'branch' },
                lualine_c = {
                    { 'diff',        draw_empty = true },
                    "'%='", -- 中央に表示する
                    { 'diagnostics', draw_empty = true },
                },
                lualine_x = { 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = {},
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            extensions = { "oil" },
        },
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        -- LSP関連のUI
        "nvimdev/lspsaga.nvim",
        event = "LspAttach",
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons',
        },
        opts = {
            symbol_in_winbar = {
                enable = false,
            },
            lightbulb = {
                virtual_text = false,
            },
            code_action = {
                extend_gitsigns = true,
            },
            finder = {
                keys = {
                    shuttle = "[w",
                    toggle_or_open = "<CR>",
                    vsplit = "v",
                    split = "s",
                    tabe = "t",
                    tabnew = "r",
                    quit = "q",
                    close = "<C-c>k",
                },
            },
            rename = {
                auto_save = true,
            },
        },
    },
    {
        -- 関数の引数を入力するときにヒントを表示
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        event = "VeryLazy",
        opts = {},
        config = function(_, opts)
            require("toggleterm").setup(opts)

            vim.keymap.set(
                { "n", "t" }, "<C-_>",
                "<cmd>ToggleTerm direction=float<CR>",
                { silent = true, }
            )

            local Terminal = require('toggleterm.terminal').Terminal
            local lazygit  = Terminal:new({
                cmd = "lazygit",
                direction = "float",
                hidden = true,
            })
            function _lazygit_toggle()
                lazygit:toggle()
            end

            vim.keymap.set(
                { "n", "t" }, "<C-g>",
                "<cmd>lua _lazygit_toggle()<CR>",
                { silent = true, desc = "Toggle LazyGit" }
            )
        end
    },
}
