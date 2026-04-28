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
    -- {
    --     "kylechui/nvim-surround",
    --     version = "*", -- Use for stability; omit to use `main` branch for the latest features
    --     event = "VeryLazy",
    --     config = true,
    -- },
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
    -- {
    --     -- ネストの展開・結合
    --     "Wansmer/treesj",
    --     keys = {
    --         { "<space>m", desc = "Split or Join code block with autodetect" },
    --         { "<space>j", desc = "Join code block" },
    --         { "<space>s", desc = "Split code block" },
    --     },
    --     dependencies = { "nvim-treesitter/nvim-treesitter" },
    --     opts = {},
    -- },
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
        version = '*',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        },
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
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        'saghen/blink.cmp',
        event = "InsertEnter",
        -- optional: provides snippets for the snippet source
        dependencies = { 'rafamadriz/friendly-snippets' },

        -- use a release tag to download pre-built binaries
        version = '1.*',
        -- AND/OR build from source
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = { preset = 'default' },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = { documentation = { auto_show = true } },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        -- make lazydev completions top priority (see `:h blink.cmp`)
                        score_offset = 100,
                    },
                },
            },

            -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
            -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
            -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
            --
            -- See the fuzzy documentation for more information
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    }
    -- {
    --     "hrsh7th/nvim-cmp",
    --     event = "InsertEnter",
    --     dependencies = {
    --         {
    --             "L3MON4D3/LuaSnip",
    --             -- follow latest release.
    --             version = "v2.*",
    --             -- install jsregexp (optional!).
    --             -- build = "make install_jsregexp"
    --             config = true,
    --             dependencies = {
    --                 {
    --                     "rafamadriz/friendly-snippets",
    --                     config = function()
    --                         require("luasnip.loaders.from_vscode").lazy_load()
    --                     end,
    --                 },
    --             },
    --             keys = {
    --                 {
    --                     "<C-l>",
    --                     function()
    --                         require("luasnip").jump(1)
    --                     end,
    --                     mode = { "i", "s" },
    --                     silent = true,
    --                 },
    --                 {
    --                     "<C-j>",
    --                     function()
    --                         require("luasnip").jump(-1)
    --                     end,
    --                     mode = { "i", "s" },
    --                     silent = true,
    --                 },
    --             },
    --         },
    --         "saadparwaiz1/cmp_luasnip",
    --
    --         "hrsh7th/cmp-nvim-lsp",
    --         "hrsh7th/cmp-path",
    --         "hrsh7th/cmp-buffer",
    --         "hrsh7th/cmp-cmdline",
    --     },
    --     opts = function(_, opts)
    --         local cmp = require("cmp")
    --
    --         opts.snippet = {
    --             expand = function(args)
    --                 require('luasnip').lsp_expand(args.body)
    --             end,
    --         }
    --
    --         opts.mapping = cmp.mapping.preset.insert({
    --             ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    --             ['<C-f>'] = cmp.mapping.scroll_docs(4),
    --             ['<C-c>'] = cmp.mapping.abort(),
    --             ['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
    --         })
    --
    --         opts.sources = cmp.config.sources({
    --             { name = "luasnip" },
    --             {
    --                 name = "lazydev",
    --                 group_index = 0, -- set group index to 0 to skip loading LuaLS completions
    --             },
    --             {
    --                 name = "nvim_lsp",
    --                 entry_filter = function(entry, ctx)
    --                     -- hide Keyword
    --                     return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Keyword'
    --                 end,
    --             },
    --             { name = "path" },
    --         }, {
    --             { name = "buffer" },
    --         })
    --     end,
    --     config = function(_, opts)
    --         local cmp = require("cmp")
    --         cmp.setup(opts)
    --
    --         cmp.setup.cmdline({ '/', '?' }, {
    --             mapping = cmp.mapping.preset.cmdline(),
    --             sources = {
    --                 { name = 'buffer' }
    --             }
    --         })
    --
    --         cmp.setup.cmdline(':', {
    --             mapping = cmp.mapping.preset.cmdline(),
    --             sources = cmp.config.sources({
    --                 { name = 'path' }
    --             }, {
    --                 { name = 'cmdline' }
    --             }),
    --             matching = { disallow_symbol_nonprefix_matching = false }
    --         })
    --     end
    -- },
}
