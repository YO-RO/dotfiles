local set = vim.opt

set.termguicolors = true

set.confirm = true

set.number = true
set.relativenumber = true
set.wrap = true

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
