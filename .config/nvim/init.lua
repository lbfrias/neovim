vim.g.mapleader = " "

require("config.lazy")
require("config.keymaps")
require("lazy").setup("plugins")

vim.wo.number = true
vim.wo.relativenumber = true
-- vim.opt.fillchars:append({ eob = " " })
vim.opt.cursorline = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.wrap = true
vim.opt.sidescroll=1
vim.opt.sidescrolloff=0

vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        vim.schedule(function()
            require("lazy").clean({ wait = true, show = false })
            require("mason-tool-installer").clean()
        end)
    end,
})
