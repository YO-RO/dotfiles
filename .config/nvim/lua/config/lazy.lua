local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
    defaults = { lazy = true, },
    dev = { path = "~/workspace/source_code/nvim_plugins", },
    install = { colorscheme = { "base16-nvim" } },
})

-- main colorscheme
vim.cmd("colorscheme base16-tokyo-night-light")
