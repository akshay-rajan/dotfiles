vim.cmd("set expandtab") -- Tab inserts spaces instead of tab character
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set clipboard=unnamedplus")
vim.cmd("inoremap jj <Esc>")
vim.opt.relativenumber = true

vim.keymap.set("n", "<C-j>", "<C-e>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-y>", { noremap = true, silent = true })

vim.g.mapleader = " "
vim.cmd("set autoindent")

vim.keymap.set("n", "<C-Left>", "gT", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Right>", "gt", { noremap = true, silent = true })

vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
