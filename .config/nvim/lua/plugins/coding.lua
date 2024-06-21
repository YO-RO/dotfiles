return {
    {
        -- move
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {
            highlight = {
                groups = {
                    label = "ErrorMsg",
                },
            },
        },
        -- stylua: ignore
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = true,
    },
    {
        "numToStr/Comment.nvim",
        lazy = false,
        opts = {
            toggler = {
                ---Line-comment toggle keymap
                line = "<leader>/",
                ---Block-comment toggle keymap
                block = "<leader>cb",
            },
            opleader = {
                ---Line-comment keymap
                line = "<leader>/",
                ---Block-comment keymap
                block = "<leader>cb",
            },
            extra = {
                ---Add comment on the line above
                above = "<leader>cO",
                ---Add comment on the line below
                below = "<leader>co",
                ---Add comment at the end of line
                eol = "<leader>cA",
            },
        },
    },
    {
        -- ネストの展開・結合
        "Wansmer/treesj",
        keys = { "<space>m", "<space>j", "<space>s" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {},
    },
    {
        "monaqa/dial.nvim",
        config = function()
            local augend = require("dial.augend")
            require("dial.config").augends:register_group({
                default = {
                    augend.integer.alias.decimal,
                    augend.integer.alias.hex,
                    augend.constant.alias.bool,
                    augend.date.alias["%Y/%m/%d"],
                    augend.date.alias["%Y-%m-%d"],
                    augend.date.alias["%H:%M"],
                    augend.date.alias["%Y年%-m月%-d日"],
                    augend.date.alias["%Y年%-m月%-d日(%ja)"],
                    augend.constant.alias.ja_weekday,
                    augend.constant.alias.ja_weekday_full,
                },
            })
        end,
        keys = {
            {
                "<C-a>",
                function()
                    require("dial.map").manipulate("increment", "normal")
                end,
                desc = "Open file explorer",
            },
            {
                "<C-a>",
                function()
                    require("dial.map").manipulate("increment", "visual")
                end,
                mode = "v",
                desc = "Open file explorer",
            },
            {
                "<C-x>",
                function()
                    require("dial.map").manipulate("decrement", "normal")
                end,
                desc = "Open file explorer",
            },
            {
                "<C-x>",
                function()
                    require("dial.map").manipulate("decrement", "visual")
                end,
                mode = "v",
                desc = "Open file explorer",
            },
        },
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
    },
}
