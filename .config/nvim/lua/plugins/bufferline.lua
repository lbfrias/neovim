return {
    'akinsho/bufferline.nvim',
    event = "VeryLazy",
    version = "*", 
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
        options = {
            termguicolors = true,
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "NEO-TREE",
                    text_align = "center"
                },
                {
                    filetype = "codecompanion",
                    text = "CODE COMPANION",
                    text_align = "center"
                },
            }
        }
    },
}

