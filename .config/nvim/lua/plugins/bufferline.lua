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
                    text = "FILES",
                    text_align = "center"
                },
                {
                    filetype = "DiffviewFiles",
                    text = "FILES",
                    text_align = "center"
                },
            }
        }
    },
}

