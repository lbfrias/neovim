vim.g.mapleader = " "

require("config.lazy")
require("config.keymaps")
require("lazy").setup("plugins")

vim.wo.number = true
vim.wo.relativenumber = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
