vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set clipboard=unnamedplus")
vim.cmd("inoremap jj <Esc>")
vim.opt.relativenumber = true
vim.keymap.set("n", "<C-j>", "<C-e>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-y>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.keymap.set("n", "<C-Up>", "<C-^>", { noremap = true, silent = true })
vim.cmd("set autoindent")

