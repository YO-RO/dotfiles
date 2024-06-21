local set = vim.opt

set.termguicolors = true

set.confirm = true

set.number = true
set.relativenumber = true
set.signcolumn = "yes"       -- 行番号の左のスペースを常に表示
set.wrap = true

set.expandtab = true
set.tabstop = 4
set.shiftwidth = 0 -- tabstopと同じ値になる
set.softtabstop = -1 -- shiftwidthと同じ値になる
-- 言語別のインデント設定
vim.api.nvim_create_augroup("indent", {})
vim.api.nvim_create_autocmd({ "FileType" }, {
    group = "indent",
    pattern = "go",
    command = "setlocal noexpandtab tabstop=8",
})

set.ignorecase = true
set.smartcase = true
-- Clear search highlight automatically
-- 参考: https://stackoverflow.com/a/77582101
vim.on_key(
    function(key)
        if vim.fn.mode() ~= "n" then
            return
        end

        local key_str = vim.fn.keytrans(key)
        local new_hlsearch_state = vim.tbl_contains({
            "n", "N",
            "*", "?", "/",
        }, key_str)

        if vim.opt.hlsearch:get() ~= new_hlsearch_state then
            vim.opt.hlsearch = new_hlsearch_state
        end
    end
)
