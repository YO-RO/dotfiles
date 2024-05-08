-- ~/.config/nvim/pack/*/opt/ にvimプラグインのディレクトリを配置して、
-- ディレクトリ名を指定することで、ロードできる。
-- pack/*/start/* に配置しても自動でロードされなかった。
-- 参考: https://neovim.io/doc/user/repeat.html#packages
vim.opt.packpath:append { "~/.config/nvim" }

-- 移動系: <C-d>や<C-u>などで滑らかなスクロースを実現する
-- https://github.com/yuttie/comfortable-motion.vim
vim.cmd("packadd comfortable-motion.vim")
