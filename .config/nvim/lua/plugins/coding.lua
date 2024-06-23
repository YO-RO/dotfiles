return {
    {
        -- move
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {
            modes = {
                search = {
                    enabled = true,
                },
                char = {
                    jump_labels = true,
                },
            },
            highlight = { groups = { label = "ErrorMsg" } },
        },
        -- stylua: ignore
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function()
                    local Flash = require("flash")

                    ---@param opts Flash.Format
                    local function format(opts)
                        -- always show first and second label
                        return {
                            { opts.match.label1, "ErrorMsg" },
                            { opts.match.label2, "MoreMsg" },
                        }
                    end

                    Flash.jump({
                        search = { mode = "search" },
                        label = { after = false, before = { 0, 0 }, uppercase = false, format = format },
                        pattern = [[\<]],
                        action = function(match, state)
                            state:hide()
                            Flash.jump({
                                search = { max_length = 0 },
                                highlight = { matches = false },
                                label = { format = format },
                                matcher = function(win)
                                    -- limit matches to the current label
                                    return vim.tbl_filter(function(m)
                                        return m.label == match.label and m.win == win
                                    end, state.results)
                                end,
                                labeler = function(matches)
                                    for _, m in ipairs(matches) do
                                        m.label = m.label2 -- use the second label
                                    end
                                end,
                            })
                        end,
                        labeler = function(matches, state)
                            local labels = state:labels()
                            for m, match in ipairs(matches) do
                                match.label1 = labels[math.floor((m - 1) / #labels) + 1]
                                match.label2 = labels[(m - 1) % #labels + 1]
                                match.label = match.label1
                            end
                        end,
                    })
                end,
                desc = "Flash"
            },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r", mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R", mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
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
                desc = "Increase value",
            },
            {
                "<C-a>",
                function()
                    require("dial.map").manipulate("increment", "visual")
                end,
                mode = "v",
                desc = "Increase value",
            },
            {
                "<C-x>",
                function()
                    require("dial.map").manipulate("decrement", "normal")
                end,
                desc = "Decrement value",
            },
            {
                "<C-x>",
                function()
                    require("dial.map").manipulate("decrement", "visual")
                end,
                mode = "v",
                desc = "Decrement value",
            },
        },
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        keys = {
            {
                "<leader>ff",
                function()
                    require('telescope.builtin').find_files()
                end,
                desc = "Find files",
            },
            {
                "<leader>fg",
                function()
                    require('telescope.builtin').live_grep()
                end,
                desc = "Live grep",
            },
            {
                "<leader>fb",
                function()
                    require('telescope.builtin').buffers()
                end,
                desc = "Find buffers",
            },
            {
                "<leader>fh",
                function()
                    require('telescope.builtin').help_tags()
                end,
                desc = "Find nvim help",
            },
        },
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            defaults = {
                sorting_strategy = "ascending",
                layout_config = {
                    prompt_position = "top"
                },
                path_display = {
                    filename_first = {
                        reverse_directories = false,
                    },
                },
            },
        },
    },
}
