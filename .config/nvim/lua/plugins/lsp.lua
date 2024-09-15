return {
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = {
            "b0o/schemastore.nvim", -- Json Yaml 用のschemaStore
        },
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            require('lspconfig').jsonls.setup({
                capabilities = capabilities,
                settings = {
                    json = {
                        schemas = require('schemastore').json.schemas(),
                        validate = { enable = true },
                    },
                },
            })

            require('lspconfig').yamlls.setup({
                settings = {
                    yaml = {
                        schemaStore = {
                            -- You must disable built-in schemaStore support if you want to use
                            -- this plugin and its advanced options like `ignore`.
                            enable = false,
                            -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                            url = "",
                        },
                        schemas = require('schemastore').yaml.schemas(),
                    },
                },
            })

            lspconfig.pylsp.setup({
                capabilities = capabilities,
                plugins = {
                    autopep8 = { enabled = false },
                    flake8 = { enabled = false, },
                    mccabe = { enabled = false, },
                    pycodestyle = { enabled = false, },
                    pyflakes = { enabled = false, },
                    pylint = { enabled = false, },
                    yapf = { enabled = false, },
                }
            })

            -- type checker
            lspconfig.pyright.setup({
                capabilities = capabilities,
            })

            -- linter and formatter
            lspconfig.ruff.setup({
                capabilities = capabilities,
            })

            lspconfig.gopls.setup({
                capabilities = capabilities,
            })

            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
            })

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    local bufopts = { noremap = true, silent = true, buffer = ev.buf }

                    vim.keymap.set(
                        "n", "<leader>lf",
                        vim.lsp.buf.format,
                        vim.tbl_extend("force", bufopts,
                            { desc = "Format current buffer" })
                    )
                    vim.keymap.set(
                        "n", "<leader>lR",
                        "<cmd>Lspsaga rename<CR>",
                        bufopts
                    )

                    vim.keymap.set(
                        "n", "<leader>lr",
                        "<cmd>Lspsaga finder ref<CR>",
                        bufopts
                    )
                    vim.keymap.set(
                        "n", "<leader>li",
                        "<cmd>Lspsaga finder imp<CR>",
                        bufopts
                    )

                    vim.keymap.set(
                        "n", "<leader>lh",
                        "<cmd>Lspsaga hover_doc<CR>",
                        bufopts
                    )
                    vim.keymap.set(
                        "n", "K",
                        "<cmd>Lspsaga peek_definition<CR>",
                        bufopts
                    )
                    vim.keymap.set(
                        "n", "<C-]>",
                        "<cmd>Lspsaga goto_definition<CR>",
                        bufopts
                    )

                    vim.keymap.set(
                        "n", "<leader>la",
                        "<cmd>Lspsaga code_action<CR>",
                        bufopts
                    )
                    vim.keymap.set(
                        "n", "<leader>ld",
                        "<cmd>Lspsaga show_line_diagnostics<CR>",
                        bufopts
                    )
                    vim.keymap.set(
                        "n", "<leader>lD",
                        "<cmd>Lspsaga show_buf_diagnostics<CR>",
                        bufopts
                    )
                    vim.keymap.set(
                        "n", "[d",
                        "<cmd>Lspsaga diagnostic_jump_prev<CR>",
                        bufopts
                    )
                    vim.keymap.set(
                        "n", "]d",
                        "<cmd>Lspsaga diagnostic_jump_next<CR>",
                        bufopts
                    )
                    vim.keymap.set(
                        { "n", "i" }, "<C-k>",
                        function()
                            require('lsp_signature').toggle_float_win()
                        end,
                        bufopts
                    )
                end,
            })
        end,
    },
    {
        'akinsho/flutter-tools.nvim',
        lazy = false,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim', -- optional for vim.ui.select
        },
        config = true,
    },
}
