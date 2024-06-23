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
                    -- builtin lsp
                    vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, bufopts)
                    vim.keymap.set("n", "<leader>lR", "<cmd>Lspsaga rename<CR>", bufopts)

                    vim.keymap.set("n", "<leader>lr", "<cmd>Lspsaga finder ref<CR>", bufopts)
                    vim.keymap.set("n", "<leader>li", "<cmd>Lspsaga finder imp<CR>", bufopts)

                    vim.keymap.set("i", "<C-\\>", vim.lsp.buf.signature_help, bufopts)
                    vim.keymap.set("n", "K", "<cmd>Lspsaga peek_definition<CR>", bufopts)
                    vim.keymap.set("n", "<C-]>", "<cmd>Lspsaga goto_definition<CR>", bufopts)

                    vim.keymap.set("n", "<leader>la", "<cmd>Lspsaga code_action<CR>", bufopts)
                    vim.keymap.set("n", "<leader>ld", "<cmd>Lspsaga show_cursor_diagnostics<CR>", bufopts)
                    vim.keymap.set("n", "<leader>lD", "<cmd>Lspsaga show_buf_diagnostics<CR>", bufopts)
                    vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", bufopts)
                    vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", bufopts)
                end,
            })
        end,
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {},
    },
}
