vim.g.mapleader = " "
vim.g.maplocalleader = [[\]]
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
