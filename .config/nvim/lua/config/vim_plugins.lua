vim.opt.packpath:append { "~/.config/nvim" }

-- ~/.config/nvim/pack/*/opt/ にvimプラグインのディレクトリを配置して、
-- ディレクトリ名を指定することで、ロードできる。
-- pack/*/start/* に配置しても自動でロードされなかった。
-- 参考: https://neovim.io/doc/user/repeat.html#packages
vim.cmd("packadd comfortable-motion.vim")
