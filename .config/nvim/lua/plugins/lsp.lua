-- TODO: Add mason, mason-lspconfig and none-ls.
return {
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        dependencies = {
            "b0o/schemastore.nvim", -- Json Yaml 用のschemaStore
        },
        config = function()
            local lsp = {
                'jsonls',
                'yamlls',
                'pylsp',
                'pyright',
                'ruff',
                'gopls',
                'rust_analyzer',
                'lua_ls',
                'html',
                'biome',
                'tailwindcss',
                'ocamllsp',
                'clangd',
            }
            -- vim.lsp.config('*', {
            --     capabilities = require('cmp_nvim_lsp').default_capabilities(),
            -- })
            vim.lsp.enable(lsp)
        end,
    },
}
