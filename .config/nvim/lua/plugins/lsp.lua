return {
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = {
            {
                "nvimdev/lspsaga.nvim",
                config = function()
                    require("lspsaga").setup({
                        symbol_in_winbar = {
                            enable = true,
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
                    })
                end
            },
        },
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require('cmp_nvim_lsp').default_capabilities()



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
                    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, bufopts)
                    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, bufopts)
                    vim.keymap.set("i", "<C-\\>", vim.lsp.buf.signature_help, bufopts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
                    vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, bufopts)
                    -- vim.keymap.set("n", "<LocalLeader>d", vim.diagnostic.setloclist, bufopts)
                    -- lsp saga
                    vim.keymap.set("n", "<leader>la", "<cmd>Lspsaga code_action<CR>", bufopts)
                    -- vim.keymap.set("i", "<LocalLeader>c", "<cmd>Lspsaga code_action<CR>", bufopts)
                    -- vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", bufopts)
                    -- vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", bufopts)
                    vim.keymap.set("n", "<C-]>", "<cmd>Lspsaga goto_definition<CR>", bufopts)
                    vim.keymap.set("n", "<leader>li", "<cmd>Lspsaga finder imp<CR>", bufopts)
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
