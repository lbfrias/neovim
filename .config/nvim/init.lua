vim.g.mapleader = " "

require("config.lazy")

local keymap = vim.keymap

-- File navigation
keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>")
keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>")
keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>")
keymap.set("n", "<leader>fh", "<cmd>FzfLua help_tags<cr>")
