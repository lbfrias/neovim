return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
    opts = {
        filesystem = {
            filtered_items = {
                hide_dotfiles = false,
                hide_gitignored = true,
            },
        follow_current_file = {
            enabled = true,
        },
        use_libuv_file_watcher=true
        },
        window = {
            mappings = {
                ["w"] = "none",
                ["<space>"] = "none",
            }
        }
    },
}
