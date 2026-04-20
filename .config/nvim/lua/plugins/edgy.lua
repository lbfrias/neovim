return {
    "folke/edgy.nvim",
    event = "VeryLazy",
    opts = {
        left = {
            {
                ft = "neo-tree",
                title = "Neo-tree",
                size = { width = 0.12 },
            }
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
        },
    } 
}
