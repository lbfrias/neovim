return {
    "folke/edgy.nvim",
    event = "VeryLazy",
    opts = {
        left = {
            {
                ft = "neo-tree",
                title = "Neo-tree",
                size = { width = 0.12 },
                filter = function(buf)
                    return vim.b[buf].neo_tree_source == "filesystem"
                end,
            },
            {
                ft = "neo-tree",
                title = "Neo-tree Git",
                size = { width = 0.12 },
                filter = function(buf)
                    return vim.b[buf].neo_tree_source == "git_status"
                end,
                pinned = true,
                collapsed = true,
                open = "Neotree position=right git_status",
            },
            {
                ft = "neo-tree",
                title = "Neo-tree Buffers",
                size = { width = 0.12 },
                filter = function(buf)
                    return vim.b[buf].neo_tree_source == "buffers"
                end,
                pinned = true,
                collapsed = true,
                open = "Neotree position=bottom buffers",
            },
        },
        right = {
            {
                ft = "copilot-chat",
                title = "Copilot Chat",
                size = { width = 0.1 },
            }
        },
        bottom = {
            {
                ft = "toggleterm",
                title = "Terminal",
                size = { height = 0.3 },
            }
        }
    } 
}
