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
        event = { "BufReadPre", "BufNewFile" },
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
        keys = {
            { "<space>m", desc = "Split or Join code block with autodetect" },
            { "<space>j", desc = "Join code block" },
            { "<space>s", desc = "Split code block" },
        },
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
    {
        -- nvimの設定ファイルの編集用のプラグイン
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                "lazy.nvim",
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        -- for folke/lazydev.nvim
        -- optional `vim.uv` typings
        "Bilal2453/luvit-meta",
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                -- follow latest release.
                version = "v2.*",
                -- install jsregexp (optional!).
                -- build = "make install_jsregexp"
                config = true,
                dependencies = {
                    {
                        "rafamadriz/friendly-snippets",
                        config = function()
                            require("luasnip.loaders.from_vscode").lazy_load()
                        end,
                    },
                },
                keys = {
                    {
                        "<C-l>",
                        function()
                            require("luasnip").jump(1)
                        end,
                        mode = { "i", "s" },
                        silent = true,
                    },
                    {
                        "<C-j>",
                        function()
                            require("luasnip").jump(-1)
                        end,
                        mode = { "i", "s" },
                        silent = true,
                    },
                },
            },
            "saadparwaiz1/cmp_luasnip",

            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
        },
        opts = function(_, opts)
            local cmp = require("cmp")

            opts.snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            }

            opts.mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-c>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
            })

            opts.sources = cmp.config.sources({
                { name = "luasnip" },
                {
                    name = "lazydev",
                    group_index = 0, -- set group index to 0 to skip loading LuaLS completions
                },
                {
                    name = "nvim_lsp",
                    entry_filter = function(entry, ctx)
                        -- hide Keyword
                        return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Keyword'
                    end,
                },
                { name = "path" },
            }, {
                { name = "buffer" },
            })
        end,
        config = function(_, opts)
            local cmp = require("cmp")
            cmp.setup(opts)

            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                }),
                matching = { disallow_symbol_nonprefix_matching = false }
            })
        end
    },
}
