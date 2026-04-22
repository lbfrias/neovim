return {
    "folke/edgy.nvim",
    event = "VeryLazy",
    opts = {
        left = {
            {
                ft = "neo-tree",
                title = "Neo-tree",
                size = { width = 0.2 },
                filter = function(buf)
                    return vim.b[buf].neo_tree_source == "filesystem"
                end,
            },
        },
        right = {
            {
                ft = "codecompanion",
                title = "Code Companion",
                size = { width = 0.4 },
            },
        },
        bottom = {
            {
                ft = "toggleterm",
                title = "Terminal",
                size = { height = 0.25 },
            },
        },
        animate = {
            enabled = false,
        },
    } 
}
