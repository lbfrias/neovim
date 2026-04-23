return {
    'akinsho/bufferline.nvim',
    lazy = false,
    version = "*", 
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
        options = {
            termguicolors = true,
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "Neo-tree",
                    text_align = "left"
                },
                {
                    filetype = "codecompanion",
                    text = "Code Companion",
                    text_align = "left"
                }
            }
        }
    },
}

